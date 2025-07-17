# ~/.assis/embed_home.py
import os
import pathlib
import gzip
import hashlib
import chromadb
import concurrent.futures
from sentence_transformers import SentenceTransformer

# Thread count
MAX_THREADS = 8
# Max file size
MAX_SIZE = 1024 * 100  # 100 KB

# Initialize embedding model
model = SentenceTransformer("all-MiniLM-L6-v2")
# Connect to ChromaDB server
chroma_client = chromadb.HttpClient(host="localhost", port=8000)
collection = chroma_client.get_or_create_collection(name="assis-docs")

# Helpers

def is_valid_file(path):
    try:
        return (
            os.path.isfile(path)
            and os.path.getsize(path) <= MAX_SIZE
            and not os.path.basename(path).startswith('.')
        )
    except:
        return False

def hash_file(path):
    try:
        with open(path, 'rb') as f: return hashlib.sha256(f.read()).hexdigest()
    except: return ''

def load_chunks(text, max_lines=20):
    lines = text.splitlines()
    return ['\n'.join(lines[i:i+max_lines]) for i in range(0, len(lines), max_lines)]

# Indexing function for /home

def index_home_file(path):
    if not is_valid_file(path): return
    try:
        with open(path, 'r', errors='ignore') as f:
            text = f.read()
        file_hash = hash_file(path)
        chunks = load_chunks(text)
        embeddings = model.encode(chunks)
        ids = [f"home_{path.replace('/', '_')}_{i}" for i in range(len(chunks))]
        metadatas = [{
            'source': path,
            'chunk_index': i,
            'file_hash': file_hash,
            'type': 'home'
        } for i in range(len(chunks))]
        collection.upsert(
            documents=chunks,
            ids=ids,
            embeddings=embeddings.tolist(),
            metadatas=metadatas
        )
        print(f"📄 [HOME] {path} ({len(chunks)} blocos)")
    except Exception as e:
        print(f"⚠️ Erro em home {path}: {e}")

print("🔄 Indexando /home ...")
home_paths = [str(p) for p in pathlib.Path.home().rglob('*') if is_valid_file(p)]
with concurrent.futures.ThreadPoolExecutor(max_workers=MAX_THREADS) as executor:
    executor.map(index_home_file, home_paths)
print("✅ /home concluído")
