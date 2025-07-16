import os
import hashlib
import chromadb
from sentence_transformers import SentenceTransformer

# Diretórios e arquivos a serem indexados
TARGET_FILES = [
    "/etc/fstab",
    "/etc/hostname",
    "/etc/pacman.conf",
    "/etc/resolv.conf",
    "/etc/sudoers",
    "/etc/systemd/system.conf",
    # "/etc/NetworkManager/NetworkManager.conf",
]

# Carrega modelo de embeddings local
model = SentenceTransformer("all-MiniLM-L6-v2")

# Conecta ao servidor ChromaDB
chroma_client = chromadb.HttpClient(host="localhost", port=8000)
collection = chroma_client.get_or_create_collection(name="assis-docs")

def hash_file(path):
    try:
        with open(path, "rb") as f:
            return hashlib.sha256(f.read()).hexdigest()
    except:
        return ""

def load_chunks(path, max_lines=20):
    try:
        with open(path, "r") as f:
            lines = f.readlines()
        chunks = []
        for i in range(0, len(lines), max_lines):
            chunk = "".join(lines[i:i+max_lines])
            chunks.append(chunk)
        return chunks
    except:
        return []

print("🔄 Iniciando indexação com ChromaDB...")
doc_ids = []
for path in TARGET_FILES:
    chunks = load_chunks(path)
    file_id = path.replace("/", "_")
    file_hash = hash_file(path)

    for idx, chunk in enumerate(chunks):
        if not chunk.strip():
            continue
        doc_id = f"{file_id}_{idx}"
        doc_ids.append(doc_id)

        embedding = model.encode(chunk).tolist()

        collection.upsert(
            documents=[chunk],
            ids=[doc_id],
            embeddings=[embedding],
            metadatas=[{
                "source": path,
                "chunk_index": idx,
                "file_hash": file_hash,
            }]
        )
        print(f"📄 Indexado: {path} [bloco {idx}]")

print("✅ Indexação concluída com sucesso!")
print(f"📦 Total de documentos no índice: {collection.count()}")