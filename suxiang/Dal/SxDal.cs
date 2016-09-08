using System;
using System.Data;
using suxiang.Model;

namespace suxiang.Dal
{
    public static class SxDal
    {
        private static readonly DbHelper DbHelper = DalHelper.GetHelper("sx");

        /// <summary>
        ///     Login
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        public static MsgModel Login(UsersModel user)
        {
            var msg = new MsgModel
            {
                State = false,
                Msg = "员工号或密码错误!",
                Data = null
            };
            try
            {
                var sql = "SELECT * FROM users a WHERE a.username='" + user.EmployeeNo + "' AND a.`password`='" + user.Password + "' AND a.state=1;";
                var result = DbHelper.ExecuteDataTable(CommandType.Text, sql);
                if (result != null && result.Rows.Count > 0)
                {
                    if (DBNull.Value != result.Rows[0]["realname"])
                        user.RealName = Convert.ToString(result.Rows[0]["realName"]);
                    if (DBNull.Value != result.Rows[0]["email"])
                        user.Email = Convert.ToString(result.Rows[0]["email"]);
                    if (DBNull.Value != result.Rows[0]["Id"])
                        user.Id = Convert.ToInt32(result.Rows[0]["Id"]);
                    if (DBNull.Value != result.Rows[0]["Group"])
                        user.Group = Convert.ToInt32(result.Rows[0]["Group"]);
                    user.Password = null;
                    msg.State = true;
                    msg.Msg = "登录成功";
                    msg.Data = user;
                }
            }
            catch (Exception)
            {
                //ignore
            }
            return msg;
        }

    }
}