import numpy as np
from pymongo import MongoClient

client = MongoClient(f"mongodb://root:root@localhost:27778/?directConnection=true")
db = client.sample

similar_docs = db["example"].aggregate([
    {
      "$vectorSearch": {
        "index": "vectorSearchIndex",
        "path": "vector",
        "queryVector": np.ones(128).tolist(),
        "numCandidates": 10,
        "limit": 10
      }
    },
    {
      "$project": {
        "_id": 0,
        "ID": 1,
        # "vector": 1,
        "score": { "$meta": "vectorSearchScore" }
      }
    }
  ])

for doc in similar_docs:
    print(doc)
