from poe_api_wrapper import AsyncPoeApi
import asyncio
from fastapi import FastAPI
from pydantic import BaseModel
from typing import Optional

app = FastAPI()

tokens = {
    'p-b': "MGd5S4gbqbIPbxWgohb5-g%3D%3D", 
    'p-lat': "NTu5d1OXs8y637rCl9xflm%2FA0dAPBxZhjEvhvTz%2BSw%3D%3D",
}

# Define a simple route
@app.get("/")
def read_root():
    return {"Hello": "World"}




async def chat(question):
    client = await AsyncPoeApi(tokens=tokens).create()
    answer = ""
    async for chunk in client.send_message(bot="gpt3_5", message=question):
        #print(chunk["response"], end='', flush=True)
        answer += chunk["response"]
    print(answer)
    return answer

        

# Define a route with a path parameter
@app.get("/items/{question}")
def read_item(question: str):
    answer = asyncio.run(chat("What is the capital of us"))
    return {"response": answer}

