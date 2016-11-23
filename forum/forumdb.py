#
# Database access functions for the web forum.
# 

import psycopg2
import time

## Database connection
DB = psycopg2.connect("dbname='forum'")


## Get posts from database.
def GetAllPosts():
    '''Get all the posts from the database, sorted with the newest first.

    Returns:
      A list of dictionaries, where each dictionary has a 'content' key
      pointing to the post content, and 'time' key pointing to the time
      it was posted.
    '''
    cursor = DB.cursor()
    cursor.execute("""SELECT content, time FROM posts ORDER BY time DESC""")
    posts = [{'content': str(row[0]), 'time': str(row[1])} for row in cursor.fetchall()]
    return posts


## Add a post to the database.
def AddPost(content):
    '''Add a new post to the database.

    Args:
      content: The text content of the new post.
    '''
    t = time.strftime('%c', time.localtime())
    DB.append((t, content))
