import logging
import os
from snowflake.connector import connect

class SnowflakeApi(object):
    """
    Wrapper to handle snowflake connection
    """

    def __init__(self, account, warehouse, database, user, pwd):
        """
        Handles snowflake connection. Connection must be closed once it is no longer needed
        :param account:
        :param warehouse:
        :param database:
        """
        self.__acct = self._account_url(account)
        self.__wh = warehouse
        self.__db = database
        self.__connection = None
        self.__user = user
        self.__pwd = pwd

    def __create_connection(self):

        try:
            # set the proxy here
            conn = connect(
                account=self.__acct
                , user=self.__user
                , password=self.__pwd
                , warehouse=self.__wh
                , database=self.__db
            )
            return conn
        except:
            raise Exception(
                "Unable to connect to snowflake for user: '{0}', warehouse: '{1}', database: '{2}'".format(
                    self.__user, self.__wh, self.__db))


    def get_connection(self):
        """
        Gets a snowflake connection. If the connection has already been initialised it is returned
        otherwise a new connection is created
        :param credentials_func: method to get database credentials.
        :return:
        """
        try:
            if self.__connection is None:
                self.__connection = self.__create_connection()
            return self.__connection
        except:
            raise Exception("Unable to initalise Snowflake connection")

    def close_connection(self):
        """
        Closes snowflake connection.
        :return:
        """
        self.__connection.close()