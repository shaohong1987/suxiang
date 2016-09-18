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

        public DataTable GetUsers(string sql)
        {
            return DbHelper.ExecuteDataTable(CommandType.Text, sql);
        }

        public MsgModel CheckUserName(string username)
        {
            var msg = new MsgModel
            {
                State = false,
                Msg = "无法获取到改员工号!",
                Data = null
            };
            var sql = "select count(1)  from users where username='" + username + "'";
            var obj=DbHelper.ExecuteScalar(CommandType.Text, sql);
            if (obj != null)
            {
                var i = Convert.ToInt32(obj);
                if (i > 0)
                {
                    msg = new MsgModel
                    {
                        State = true,
                        Msg = "成功获取到该员工号!",
                        Data = i
                    };
                }
            }
            return msg;
        }

        public MsgModel AddNewUser(UsersModel model)
        {
            var msg = new MsgModel
            {
                State = false,
                Msg = "无法添加新用户!",
                Data = null
            };
            try
            {
                var sql = "INSERT INTO USERS(username,password,realname,email,state,`group`) VALUES('" + model.EmployeeNo +
                          "','" + model.Password + "','" + model.RealName + "','" + model.Email + "'," + (model.State?1:0) +
                          "," + model.Group + ");";
                if (DbHelper.ExecuteNonQuery(CommandType.Text, sql) > 0)
                {
                    msg.State = true;
                    msg.Msg = "成功添加新用户";
                }
            }
            catch (Exception)
            {
                //ignore
            }
            return msg;
        }

        public MsgModel UpdateUserInfo(UsersModel model)
        {
            var msg = new MsgModel
            {
                State = false,
                Msg = "无法更新用户信息!",
                Data = null
            };
            try
            {
                var sql = "update USERS set password='" + model.Password + "',realname='" + model.RealName + "',email='" +
                          model.Email + "',state=" + model.State + ",`group`=" + model.Group + " where username='" +
                          model.EmployeeNo + "';";
                if (string.IsNullOrEmpty(model.Password))
                {
                    sql = "update USERS set realname='"+model.RealName+"',email='"+model.Email+"',state="+ (model.State ? 1 : 0) + ",`group`=" +model.Group+" where username='" + model.EmployeeNo + "';";
                }
                if (DbHelper.ExecuteNonQuery(CommandType.Text, sql) > 0)
                {
                    msg.State = true;
                    msg.Msg = "成功更新用户信息";
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

	    public MsgModel GetAllProjects()
	    {
            var msg = new MsgModel
            {
                State = false,
                Msg = "无法获取到项目信息!",
                Data = null
            };
            try
            {
                const string sql = "SELECT * FROM `projects`;";
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
                        if (DBNull.Value != row["projectleaderid"])
                            project.Projectleaderid = Convert.ToInt32(row["projectleaderid"]);
                        if (DBNull.Value != row["projectleader"])
                            project.Projectleader = Convert.ToString(row["projectleader"]);
                        if (DBNull.Value != row["buildingTotal"])
                            project.BuildingTotal = Convert.ToInt32(row["buildingTotal"]);
                        if (DBNull.Value != row["state"])
                            project.State = Convert.ToBoolean(row["state"]);
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

	    public MsgModel GetProjectinfo(string projectid)
	    {
            var msg = new MsgModel
            {
                State = false,
                Msg = "无法获取到项目信息!",
                Data = null
            };
            try
            {
                 string sql = "SELECT * FROM `projectinfo` where projectid="+projectid+";";
                var result = DbHelper.ExecuteDataTable(CommandType.Text, sql);
                if ((result != null) && (result.Rows.Count > 0))
                {
                    var projects = new List<ProjectInfoModel>();
                    foreach (DataRow row in result.Rows)
                    {
                        var project = new ProjectInfoModel();
                        if (DBNull.Value != row["Id"])
                            project.Id = Convert.ToInt32(row["Id"]);
                        if (DBNull.Value != row["projectname"])
                            project.Projectname = Convert.ToString(row["projectname"]);
                        if (DBNull.Value != row["Buildingid"])
                            project.Buildingid = Convert.ToInt32(row["Buildingid"]);
                        if (DBNull.Value != row["BuildingLeader"])
                            project.BuildingLeader = Convert.ToString(row["BuildingLeader"]);
                        if (DBNull.Value != row["BuildingLeaderId"])
                            project.BuildingLeaderId = Convert.ToInt32(row["BuildingLeaderId"]);
                        if (DBNull.Value != row["state"])
                            project.State = Convert.ToBoolean(row["state"]);
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


        public MsgModel GetProject(string projectid)
        {
            var msg = new MsgModel
            {
                State = false,
                Msg = "无法获取到项目信息!",
                Data = null
            };
            try
            {
                string sql = "SELECT * FROM `projects` where id=" + projectid + ";";
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
                        if (DBNull.Value != row["Projectleaderid"])
                            project.Projectleaderid = Convert.ToInt32(row["Projectleaderid"]);
                        if (DBNull.Value != row["Projectleader"])
                            project.Projectleader = Convert.ToString(row["Projectleader"]);
                        if (DBNull.Value != row["state"])
                            project.State = Convert.ToBoolean(row["state"]);
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

        public DataTable GetProblems(string sql)
        {
            return DbHelper.ExecuteDataTable(CommandType.Text, sql);
        }

        public MsgModel UpdatePwd(string sql)
        {
            var msg = new MsgModel
            {
                State = false,
                Msg = "旧密码不正确!",
                Data = null
            };
            try
            {
                if (DbHelper.ExecuteNonQuery(CommandType.Text, sql) > 0)
                {
                    msg.State = true;
                    msg.Msg = "成功修改密码";
                }
            }
            catch (Exception)
            {
                //ignore
            }
            return msg;
        }

        public MsgModel UpdateProjectState(string sql)
        {
            var msg = new MsgModel
            {
                State = false,
                Msg = "项目编号不正确!",
                Data = null
            };
            try
            {
                if (DbHelper.ExecuteNonQuery(CommandType.Text, sql) > 0)
                {
                    msg.State = true;
                    msg.Msg = "成功修改";
                }
            }
            catch (Exception)
            {
                //ignore
            }
            return msg;
        }

	    public int GetId(string sql)
	    {
		    var obj = DbHelper.ExecuteScalar(CommandType.Text, sql);
		    if (obj != null)
		    {
			    var id = Convert.ToInt32(obj);
			    return id;
		    }
		    return -1;
	    }
    }
}