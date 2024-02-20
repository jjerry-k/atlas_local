from pymongo import MongoClient
client = MongoClient(f"mongodb://root:root@localhost:27778/?directConnection=true")
db = client.sample
collection = db["example"]

import numpy as np

dimensions = 128

for i in range(9):
    collection.insert_one({
        "ID": i,
        "vector": np.random.random(dimensions).tolist()
    })
    
collection.insert_one({
        "ID": 9,
        "vector": np.ones(dimensions).tolist()
    })
