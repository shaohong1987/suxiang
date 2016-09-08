using System;
using System.Configuration;
using System.Data;

namespace suxiang
{
    public static class DalHelper
    {
        /// <summary>
        /// 从Web.config从读取数据库的连接以及数据库类型
        /// </summary>
        public static DbHelper GetHelper(string connectionStringName)
        {
            ConnectionStringSettings connectionSetting = ConfigurationManager.ConnectionStrings[connectionStringName];
            string className = connectionSetting.ProviderName;
            DbHelper db = DbHelper.Create(className);
            db.ConnectionString = connectionSetting.ConnectionString;
            return db;
        }

        /// <summary>
        /// 对IDataReader读取依次执行事件
        /// </summary>
        public static void ExecuteReaderAction(IDataReader dr, Action<IDataReader> readAction)
        {
            while (dr.Read())
            {
                if (readAction != null) readAction(dr);
            }
        }

        /// <summary>
        /// 对IDataReader读取依次执行事件
        /// </summary>
        public static void ExecuteReaderAction(IDataReader dr, int first, int count, Action<IDataReader> readAction)
        {
            for (int i = 0; i < first; i++)
            {
                if (!dr.Read()) return;
            }

            int resultsFetched = 0;
            while (resultsFetched < count && dr.Read())
            {
                if (readAction != null) readAction(dr);
                resultsFetched++;
            }
        }
    }
}