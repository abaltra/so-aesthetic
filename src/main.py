import requests
import os
from io import BytesIO
from PIL import Image, ImageFont, ImageDraw
import textwrap
import random
import tweepy

def get_image():
    print("Getting image")
    response = requests.get('https://picsum.photos/800/600.jpg?blur=2', stream=True)
    return response.content

def get_inspo():
    print("Getting quote")
    response = requests.get('https://api.quotable.io/random')
    return response.json()

def be_aesthetic():
    image = get_image()
    inspo = get_inspo()

    print("Being aesthethic")

    # well need to wrap long texts
    wrapped_inspo = textwrap.wrap(inspo['content'], 50)

    img = Image.open(BytesIO(image))
    font = ImageFont.truetype('Caveat-Regular.ttf', 40)

    color = 'rgb(255, 255, 255)'
    draw = ImageDraw.Draw(img, 'RGBA')

    # make sure it fits
    base_y = random.randint(50, 550 - 45 * len(wrapped_inspo) - 45)
    draw.rectangle([(0, 0), (800, 600)], (0, 0, 0, 125))
    draw.text((50, base_y), "\n".join(wrapped_inspo), fill=color, font=font)
    draw.text((350, base_y + 45 * len(wrapped_inspo)), f"- {inspo['author']}", fill=color, font=font)

    img.save('/tmp/aesthetic.jpg')

    return inspo['author']

def share_inspo(author):
    auth = tweepy.OAuthHandler(
            os.getenv("TWITTER_CONSUMER_KEY"),
            os.getenv("TWITTER_CONSUMER_SECRET")
            )
    auth.set_access_token(
            os.getenv("TWITTER_ACCESS_TOKEN"),
            os.getenv("TWITTER_ACCESS_TOKEN_SECRET")
            )
    api = tweepy.API(auth)

    print("Tweeting")
    author = author.replace(" ", "").replace("'", "")
    media = api.media_upload("/tmp/aesthetic.jpg")
    api.update_status(media_ids=[media.media_id], status=f"#inspiration #quote #{author}")

def clean():
        print("Forgetting")
        os.remove("/tmp/aesthetic.jpg")

def handler(event, context):
    author = be_aesthetic()
    share_inspo(author)

if __name__ == "__main__":
    print("Running locally")
    handler()
