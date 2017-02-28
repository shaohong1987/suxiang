using System;
using System.Collections.Generic;
using System.Data;
using suxiang.mobile.Dal;
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
            var obj = DbHelper.ExecuteScalar(CommandType.Text, sql);
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
                          "','" + model.Password + "','" + model.RealName + "','" + model.Email + "'," + (model.State ? 1 : 0) +
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
                    sql = "update USERS set realname='" + model.RealName + "',email='" + model.Email + "',state=" + (model.State ? 1 : 0) + ",`group`=" + model.Group + " where username='" + model.EmployeeNo + "';";
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
                        if (DBNull.Value != row["Constructionleaderid"])
                            project.Constructionleaderid = Convert.ToInt32(row["Constructionleaderid"]);
                        if (DBNull.Value != row["Constructionleader"])
                            project.Constructionleader = Convert.ToString(row["Constructionleader"]);
                        if (DBNull.Value != row["Accountantid"])
                            project.Accountantid = Convert.ToInt32(row["Accountantid"]);
                        if (DBNull.Value != row["Accountant"])
                            project.Accountant = Convert.ToString(row["Accountant"]);
                        if (DBNull.Value != row["Productleaderid"])
                            project.Productleaderid = Convert.ToInt32(row["Productleaderid"]);
                        if (DBNull.Value != row["Productleader"])
                            project.Productleader = Convert.ToString(row["Productleader"]);
                        if (DBNull.Value != row["Qualityleaderid"])
                            project.Qualityleaderid = Convert.ToInt32(row["Qualityleaderid"]);
                        if (DBNull.Value != row["Qualityleader"])
                            project.Qualityleader = Convert.ToString(row["Qualityleader"]);
                        if (DBNull.Value != row["Safetyleaderid"])
                            project.Safetyleaderid = Convert.ToInt32(row["Safetyleaderid"]);
                        if (DBNull.Value != row["Safetyleader"])
                            project.Safetyleader = Convert.ToString(row["Safetyleader"]);
                        if (DBNull.Value != row["Storekeeperid"])
                            project.Storekeeperid = Convert.ToInt32(row["Storekeeperid"]);
                        if (DBNull.Value != row["Storekeeper"])
                            project.Storekeeper = Convert.ToString(row["Storekeeper"]);
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
                string sql = "SELECT * FROM `projectinfo` where projectid=" + projectid + ";";
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

        public DataTable GetData(string sql)
        {
            return DbHelper.ExecuteDataTable(CommandType.Text, sql);
        }

        public List<TempEntity> GetProjectsByUid(int uid)
        {
            List<TempEntity> result = null;
            string sql = "SELECT id,0 as t,-1 as bid FROM projects WHERE projectleaderid=" + uid +
                         " UNION SELECT id,1 as t,-1 as bid FROM projects WHERE productleaderid=" + uid +
                         " UNION SELECT id,3 as t,-1 as bid FROM projects WHERE constructionleaderid=" + uid +
                         " UNION SELECT id,4 as t,-1 as bid FROM projects WHERE safetyleaderid=" + uid +
                         " UNION SELECT id,5 as t,-1 as bid FROM projects WHERE qualityleaderid=" + uid +
                         " UNION SELECT id,6 as t,-1 as bid FROM projects WHERE storekeeperid=" + uid +
                         " UNION SELECT projectid,2 as t,buildingid as bid FROM projectinfo WHERE buildingleaderid=" +
                         uid + ";";
            var data = DbHelper.ExecuteDataTable(CommandType.Text, sql);
            if ((data != null) && (data.Rows.Count > 0))
            {
                result = new List<TempEntity>();
                foreach (DataRow row in data.Rows)
                {
                    var entity = new TempEntity();
                    if (DBNull.Value != row["id"])
                        entity.Id = (Convert.ToInt32(row["id"]));
                    if (DBNull.Value != row["t"])
                        entity.T = (Convert.ToInt32(row["t"]));
                    if (DBNull.Value != row["bid"])
                        entity.BId = (Convert.ToInt32(row["bid"]));
                    result.Add(entity);
                }
            }
            return result;
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


        #region 处理业务流程

        /// <summary>
        /// 由于最后都是项目负责人/生产经理，和总经理，所以在没有先后关系的情况下，currentUser为-1，currentPage为Null
        /// 但是用state中加以区分，
        /// -1：作废，
        /// 0：完成，
        /// 1：等待总经理处理，
        /// 2：等待项目负责人/生产经理处理，
        /// 3,4：正处于流程中，
        /// 5：该单据被退回到填表人手中。
        /// 
        /// 总经理可以看到所有状态>=0的表单
        /// 但是处理只能是状态1单据。
        /// 对于质量，安全这两个单据的填表人修改，不影响表单流程。且只能修改整改状态和问题等级。
        /// step默认填表后的值为4
        /// projectleaderid
        /// productleaderid
        /// accountantid
        /// constructionleaderid
        /// safetyleaderid
        /// qualityleaderid
        /// storekeeperid
        /// buildingleaderid
        /// </summary>
        /// <param name="projectId"></param>
        /// <param name="buildingid"></param>
        /// <param name="formType"></param>
        /// <param name="step"></param>
        /// <returns></returns>
        public static NextStep GetNextStep(int projectId, int buildingid, string formType, int step)
        {
            NextStep result = null;
            switch (formType)
            {
                case "problem_sercurity":
                    switch (step)
                    {
                        case 2://项目负责人/生产经理处理
                            result = new NextStep
                            {
                                CurrentPage = "SecurityQuestionForm_Remark.aspx?formId=",
                                CurrentUser = GetUserIdByCondition(projectId, buildingid, "projectleaderid"),
                                State = step,
                                Status = "等待项目负责人/生产经理处理"
                            };
                            break;
                        case 1://总经理处理
                            result = new NextStep
                            {
                                CurrentPage = "SecurityQuestionForm_Summary.aspx?formId=",
                                CurrentUser = GetGeId(),
                                State = step,
                                Status = "等待总经理处理"
                            };
                            break;
                        case 0://总经理处理完成
                            result = new NextStep()
                            {
                                CurrentPage = "",
                                CurrentUser = -1,
                                State = step,
                                Status = "表单处理完成"
                            };
                            break;
                    }
                    break;
                case "problem_quality":
                    switch (step)
                    {
                        case 2://项目负责人/生产经理处理
                            result = new NextStep
                            {
                                CurrentPage = "QualityQuestionForm_Remark.aspx?formId=",
                                CurrentUser = GetUserIdByCondition(projectId, buildingid, "projectleaderid"),
                                State = step,
                                Status = "等待项目负责人/生产经理处理"
                            };
                            break;
                        case 1://总经理处理
                            result = new NextStep
                            {
                                CurrentPage = "QualityQuestionForm_Summary.aspx?formId=",
                                CurrentUser = GetGeId(),
                                State = step,
                                Status = "等待总经理处理"
                            };
                            break;
                        case 0://总经理处理完成
                            result = new NextStep()
                            {
                                CurrentPage = "",
                                CurrentUser = -1,
                                State = step,
                                Status = "表单处理完成"
                            };
                            break;
                    }
                    break;
                case "cost_labor":
                    switch (step)
                    {
                        case 5://退回到填表人
                            result = new NextStep
                            {
                                CurrentPage = "LaborCostForm_Update.aspx?formId=",
                                CurrentUser = -2,//表示为当前表单的提交人
                                State = step,
                                Status = "退回到填表人"
                            };
                            break;
                        case 4://班组长确认
                            result = new NextStep
                            {
                                CurrentPage = "LaborCostForm_Comfirm.aspx?formId=",
                                CurrentUser = -3,//表示为当天表单的班组长ID
                                State = step,
                                Status = "等待班组长处理"
                            };
                            break;
                        case 3://栋号长确认
                            result = new NextStep
                            {
                                CurrentPage = "LaborCostForm_ReComfirm.aspx?formId=",
                                CurrentUser = GetUserIdByCondition(projectId, buildingid, "buildingleaderid"),
                                State = step,
                                Status = "等待栋号长处理"
                            };
                            break;
                        case 2://项目负责人/生产经理处理
                            result = new NextStep
                            {
                                CurrentPage = "LaborCostForm_Remark.aspx?formId=",
                                CurrentUser = GetUserIdByCondition(projectId, buildingid, "projectleaderid"),
                                State = step,
                                Status = "等待项目负责人/生产经理处理"
                            };
                            break;
                        case 1://总经理处理
                            result = new NextStep
                            {
                                CurrentPage = "LaborCostForm_Summary.aspx?formId=",
                                CurrentUser = GetGeId(),
                                State = step,
                                Status = "等待总经理处理"
                            };
                            break;
                        case 0://总经理处理完成
                            result = new NextStep()
                            {
                                CurrentPage = "",
                                CurrentUser = -1,
                                State = step,
                                Status = "表单处理完成"
                            };
                            break;
                    }
                    break;
                case "cost_management":
                    switch (step)
                    {
                        case 5://退回到填表人
                            result = new NextStep
                            {
                                CurrentPage = "ManageCostForm_Update.aspx?formId=",
                                CurrentUser = -2,//表示为当前表单的提交人
                                State = step,
                                Status = "退回到填表人"
                            };
                            break;
                        case 2://项目负责人/生产经理处理
                            result = new NextStep
                            {
                                CurrentPage = "ManageCostForm_Remark.aspx?formId=",
                                CurrentUser = GetUserIdByCondition(projectId, buildingid, "projectleaderid"),
                                State = step,
                                Status = "等待项目负责人/生产经理处理"
                            };
                            break;
                        case 1://总经理处理
                            result = new NextStep
                            {
                                CurrentPage = "ManageCostForm_Summary.aspx?formId=",
                                CurrentUser = GetGeId(),
                                State = step,
                                Status = "等待总经理处理"
                            };
                            break;
                        case 0://总经理处理完成
                            result = new NextStep()
                            {
                                CurrentPage = "",
                                CurrentUser = -1,
                                State = step,
                                Status = "表单处理完成"
                            };
                            break;
                    }
                    break;
                case "cost_material":
                    switch (step)
                    {
                        case 5://退回到填表人
                            result = new NextStep
                            {
                                CurrentPage = "MaterialCostForm_Update.aspx?formId=",
                                CurrentUser = -2,//表示为当前表单的提交人
                                State = step,
                                Status = "退回到填表人"
                            };
                            break;
                        case 4://班组长确认
                            result = new NextStep
                            {
                                CurrentPage = "MaterialCostForm_Comfirm.aspx?formId=",
                                CurrentUser = -3,//表示为当天表单的班组长ID
                                State = step,
                                Status = "等待班组长处理"
                            };
                            break;
                        case 3://栋号长确认
                            result = new NextStep
                            {
                                CurrentPage = "MaterialCostForm_ReComfirm.aspx?formId=",
                                CurrentUser = GetUserIdByCondition(projectId, buildingid, "buildingleaderid"),
                                State = step,
                                Status = "等待栋号长处理"
                            };
                            break;
                        case 2://项目负责人/生产经理处理
                            result = new NextStep
                            {
                                CurrentPage = "MaterialCostForm_Remark.aspx?formId=",
                                CurrentUser = GetUserIdByCondition(projectId, buildingid, "projectleaderid"),
                                State = step,
                                Status = "等待项目负责人/生产经理处理"
                            };
                            break;
                        case 1://总经理处理
                            result = new NextStep
                            {
                                CurrentPage = "MaterialCostForm_Summary.aspx?formId=",
                                CurrentUser = GetGeId(),
                                State = step,
                                Status = "等待总经理处理"
                            };
                            break;
                        case 0://总经理处理完成
                            result = new NextStep()
                            {
                                CurrentPage = "",
                                CurrentUser = -1,
                                State = step,
                                Status = "表单处理完成"
                            };
                            break;
                    }
                    break;
                case "cost_materialauxiliary":
                    switch (step)
                    {
                        case 5://退回到填表人
                            result = new NextStep
                            {
                                CurrentPage = "MaterialAuxiliaryCostForm_Update.aspx?formId=",
                                CurrentUser = -2,//表示为当前表单的提交人
                                State = step,
                                Status = "退回到填表人"
                            };
                            break;
                        case 4://班组长确认
                            result = new NextStep
                            {
                                CurrentPage = "MaterialAuxiliaryCostForm_Comfirm.aspx?formId=",
                                CurrentUser = -3,//表示为当天表单的班组长ID
                                State = step,
                                Status = "等待班组长处理"
                            };
                            break;
                        case 3://栋号长确认
                            result = new NextStep
                            {
                                CurrentPage = "MaterialAuxiliaryCostForm_ReComfirm.aspx?formId=",
                                CurrentUser = GetUserIdByCondition(projectId, buildingid, "buildingleaderid"),
                                State = step,
                                Status = "等待栋号长处理"
                            };
                            break;
                        case 2://项目负责人/生产经理处理
                            result = new NextStep
                            {
                                CurrentPage = "MaterialAuxiliaryCostForm_Remark.aspx?formId=",
                                CurrentUser = GetUserIdByCondition(projectId, buildingid, "projectleaderid"),
                                State = step,
                                Status = "等待项目负责人/生产经理处理"
                            };
                            break;
                        case 1://总经理处理
                            result = new NextStep
                            {
                                CurrentPage = "MaterialAuxiliaryCostForm_Summary.aspx?formId=",
                                CurrentUser = GetGeId(),
                                State = step,
                                Status = "等待总经理处理"
                            };
                            break;
                        case 0://总经理处理完成
                            result = new NextStep()
                            {
                                CurrentPage = "",
                                CurrentUser = -1,
                                State = step,
                                Status = "表单处理完成"
                            };
                            break;
                    }
                    break;
            }
            return result;
        }

        /// <summary>
        /// </summary>
        /// <param name="projectId"></param>
        /// <param name="buildingid"></param>
        /// <param name="columnName"></param>
        /// <returns></returns>
        private static int GetUserIdByCondition(int projectId, int buildingid, string columnName)
        {
            var sql = "";
            if (buildingid == -1)
            {
                sql = "select  " + columnName + " from projects where id=" + projectId + "  limit 1;";
            }
            else
            {
                sql = "select   " + columnName + " from projectinfo where projectid=" + projectId + " and buildingid='" + buildingid + "'   limit 1;";
            }
            var obj = DbHelper.ExecuteScalar(CommandType.Text, sql);
            if (obj == null) return -1;
            var id = Convert.ToInt32(obj);
            return id;
        }

        /// <summary>
        /// 获取总经理的ID
        /// </summary>
        /// <returns></returns>
        private static int GetGeId()
        {
            var sql = "select Id from users where `group`=0 and state=1 limit 1;";
            var obj = DbHelper.ExecuteScalar(CommandType.Text, sql);
            if (obj == null) return -1;
            var id = Convert.ToInt32(obj);
            return id;
        }

        #endregion
    }
}