query_begin = """SELECT *  
          FROM my_Table"""


def get_queries_list(query):
    result = query.replace('\n', '').strip()
    return result


query_result = get_queries_list(query_begin)
print(query_result)
