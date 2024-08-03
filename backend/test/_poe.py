from poe_api_wrapper import AsyncPoeApi
import asyncio
tokens = {
    'p-b': "MGd5S4gbqbIPbxWgohb5-g%3D%3D", 
    'p-lat': "NTu5d1OXs8y637rCl9xflm%2FA0dAPBxZhjEvhvTz%2BSw%3D%3D",
}

async def main():
    client = await AsyncPoeApi(tokens=tokens).create()
    message = "Explain quantum computing in simple terms"
    async for chunk in client.send_message(bot="gpt3_5", message=message):
        print(chunk["response"], end='', flush=True)
        
asyncio.run(main())