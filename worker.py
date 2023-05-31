import json
import asyncio
from asyncio import ClientSession

file = open("/root/heartbeat/url.json")
data = json.load(file)

async def main() -> None:
    session: ClientSession = ClientSession()
    while True:
        try:
            await session.get(f"{data['url']}")
        except:
            continue
        await asyncio.sleep(300)

asyncio.run(main())