#
# Database access functions for the web forum.
# 

import psycopg2

# Database connection
DB = psycopg2.connect("dbname='forum'")


# Get posts from database.
def get_all_posts():
    """Get all the posts from the database, sorted with the newest first.

    Returns:
      A list of dictionaries, where each dictionary has a 'content' key
      pointing to the post content, and 'time' key pointing to the time
      it was posted.
    """
    cursor = DB.cursor()
    cursor.execute("""SELECT content, time FROM posts ORDER BY time DESC""")
    posts = [{'content': str(row[0]), 'time': str(row[1])} for row in cursor.fetchall()]
    return posts


# Add a post to the database.
def add_post(content):
    """Add a new post to the database.

    Args:
      content: The text content of the new post.
    """
    cursor = DB.cursor()
    cursor.execute("INSERT INTO posts (content) VALUES (%s)", (content,))
    DB.commit()
