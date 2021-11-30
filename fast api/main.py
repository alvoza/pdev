# This is a sample Python script.

# Press ⌃R to execute it or replace it with your code.
# Press Double ⇧ to search everywhere for classes, files, tool windows, actions, and settings.

from fastapi import FastAPI
from typing import List, Optional
from fastapi import FastAPI, Query

app = FastAPI()

@app.get("/")
def read_root():
    return {"Hello": "World"}

@app.get("/items/{item_id}")
def read_item(item_id: int):
    return {"item_id": item_id}

@app.get("/operaciones/suma")
async def read_items(q: Optional[List[int]] = Query(None)):
    x = 0
    for i in range(len(q)):
        x+=q[i]
    res = {"suma": x}
    return res

@app.get("/operaciones/resta")
async def read_items(q: Optional[List[int]] = Query(None)):
    x = q[0]
    for i in range(1,len(q)):
        x-=q[i]
    res = {"resta": x}
    return res

@app.get("/operaciones/multiplicacion")
async def read_items(q: Optional[List[int]] = Query(None)):
    x = 1
    for i in range(len(q)):
        x = x*q[i]
    res = {"multiplicacion": x}
    return res

@app.get("/operaciones/division")
async def read_items(q: Optional[List[int]] = Query(None)):
    x = q[0]
    for i in range(1,len(q)):
        x = x / q[i]
    res = {"division": x}
    return res

@app.get("/operaciones")
def operaciones(op: str, q: List[int] = Query(None)):
    x = 0

    if(op=="suma"):
        x = 0
        for i in range(len(q)):
            x+=q[i]
    elif(op=="resta"):
        x = q[0]
        for i in range(1,len(q)):
            x-=q[i]
    elif(op=="multiplicacion"):
        x = 1
        for i in range(len(q)):
            x = x*q[i]
    else:
        x = q[0]
        for i in range(1,len(q)):
            x = x / q[i]

    res = {"operacion": op, "resultado": x}
    return res