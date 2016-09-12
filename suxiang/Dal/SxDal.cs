using System;
using System.Collections.Generic;
using System.Data;
using suxiang.Model;

namespace suxiang.Dal
{
    public class SxDal
    {
        private static readonly DbHelper DbHelper = DalHelper.GetHelper("sx");

        /// <summary>
        ///     Login
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        public MsgModel Login(UsersModel user)
        {
            var msg = new MsgModel
            {
                State = false,
                Msg = "员工号或密码错误!",
                Data = null
            };
            try
            {
                var sql = "SELECT * FROM users a WHERE a.username='" + user.EmployeeNo + "' AND a.`password`='" +
                          user.Password + "' AND a.state=1;";
                var result = DbHelper.ExecuteDataTable(CommandType.Text, sql);
                if ((result != null) && (result.Rows.Count > 0))
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

        #region

        public MsgModel GetProjects()
        {
            var msg = new MsgModel
            {
                State = false,
                Msg = "无法获取到项目信息!",
                Data = null
            };
            try
            {
                const string sql = "SELECT id,projectname FROM `projects` a WHERE a.state=1;";
                var result = DbHelper.ExecuteDataTable(CommandType.Text, sql);
                if ((result != null) && (result.Rows.Count > 0))
                {
                    var projects = new List<ProjectModel>();
                    foreach (DataRow row in result.Rows)
                    {
                        var project = new ProjectModel();
                        if (DBNull.Value != row["Id"])
                            project.Id = Convert.ToInt32(row["Id"]);
                        if (DBNull.Value != row["projectname"])
                            project.Projectname = Convert.ToString(row["projectname"]);
                        projects.Add(project);
                    }
                    msg.State = true;
                    msg.Msg = "成功获取项目信息";
                    msg.Data = projects;
                }
            }
            catch (Exception)
            {
                //ignore
            }
            return msg;
        }

        public MsgModel GetBuildings()
        {
            var msg = new MsgModel
            {
                State = false,
                Msg = "无法获取到栋号信息!",
                Data = null
            };
            try
            {
                const string sql = "SELECT projectid,buildingid FROM `projectinfo` a WHERE a.state=1;";
                var result = DbHelper.ExecuteDataTable(CommandType.Text, sql);
                if ((result != null) && (result.Rows.Count > 0))
                {
                    var projects = new List<ProjectInfoModel>();
                    foreach (DataRow row in result.Rows)
                    {
                        var project = new ProjectInfoModel();
                        if (DBNull.Value != row["projectid"])
                            project.Projectid = Convert.ToInt32(row["projectid"]);
                        if (DBNull.Value != row["buildingid"])
                            project.Buildingid = Convert.ToInt32(row["buildingid"]);
                        projects.Add(project);
                    }
                    msg.State = true;
                    msg.Msg = "成功获取栋号信息";
                    msg.Data = projects;
                }
            }
            catch (Exception)
            {
                //ignore
            }
            return msg;
        }

        public MsgModel AddData(string sql)
        { 
            var msg = new MsgModel
            {
                State = false,
                Msg = "无法提交数据!",
                Data = null
            };
            try
            {
                var result = DbHelper.ExecuteNonQuery(CommandType.Text, sql) > 0;
                if (result)
                    msg = new MsgModel
                    {
                        State = true,
                        Msg = "成功提交数据!",
                        Data = null
                    };
            }
            catch (Exception)
            {
                //
            }
            return msg;
        }

        #endregion

    }
}