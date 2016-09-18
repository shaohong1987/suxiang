using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.SessionState;
using suxiang.Dal;
using suxiang.Model;

namespace suxiang.Handler
{
    /// <summary>
    ///     Process 的摘要说明
    /// </summary>
    public class Process : IHttpHandler, IRequiresSessionState
    {
        public void ProcessRequest(HttpContext context)
        {
            var json = "";
            var action = WebHelper.GetActionStr(context, "action");
            UsersModel um = null;
            if (context.Session["user"] != null)
                um = (UsersModel)context.Session["user"];
            else
                context.Response.Redirect("~/Login.aspx");
            switch (action)
            {
                case "getproject":
                    {
                        var projectid = WebHelper.GetActionStr(context, "projectid");
                        var msg = new SxDal().GetProject(projectid);
                        json = WebHelper.GetObjJson(msg);
                        break;
                    }
                case "getprojectinfo":
                    {
                        var projectid = WebHelper.GetActionStr(context, "projectid");
                        var msg = new SxDal().GetProjectinfo(projectid);
                        json = WebHelper.GetObjJson(msg);
                        break;
                    }
                case "updateprojectform":
                    {
                        MsgModel msg;
                        try
                        {
                            var projectid = WebHelper.GetActionInt(context, "projectid");
                            var projectname = WebHelper.GetActionStr(context, "projectname");
                            var manage = WebHelper.GetActionStr(context, "manage");//bArr
                            var marr = manage.Split('-');
                            var list = (from string item in context.Request.Params where item.StartsWith("bArr") select context.Request.Params[item] into v select v.Split(',')).ToList();
                            var sql = "update projects set projectname='" + projectname + "',projectleaderid=" + marr[0] + ",projectleader='" + marr[1] + "',buildingTotal=" + list.Count + " where id=" + projectid + ";";
                            sql += "delete from projectinfo where projectid=" + projectid + ";";
                            sql += list.Aggregate("", (current, item) => current + ("insert into projectinfo (projectid,projectname,buildingid,buildingleaderid,buildingleader,state)values(" + projectid + ",'" + projectname + "'," + item[0] + "," + item[1] + ",'" + item[2] + "',1);"));
                            msg = new SxDal().AddData(sql);
                        }
                        catch (Exception)
                        {
                            msg = new MsgModel
                            {
                                State = false,
                                Msg = "出错了",
                                Data = null
                            };
                        }
                        json = WebHelper.GetObjJson(msg);
                        break;
                    }
                case "addprojectform":
                    {
                        MsgModel msg;
                        try
                        {
                            var projectname = WebHelper.GetActionStr(context, "projectname");
                            var manage = WebHelper.GetActionStr(context, "manage");//bArr
                            var marr = manage.Split('-');
                            var list = (from string item in context.Request.Params where item.StartsWith("bArr") select context.Request.Params[item] into v select v.Split(',')).ToList();
                            var sql = "insert into projects(projectname,projectleaderid,projectleader,buildingTotal,state)values('" + projectname + "'," + marr[0] + ",'" + marr[1] + "'," + list.Count + ",1);select @@identity;";
                            var id = new SxDal().GetId(sql);
                            if (id > 0)
                            {
                                sql = list.Aggregate("", (current, item) => current + ("insert into projectinfo (projectid,projectname,buildingid,buildingleaderid,buildingleader,state)values(" + id + ",'" + projectname + "'," + item[0] + "," + item[1] + ",'" + item[2] + "',1);"));
                                msg = new SxDal().AddData(sql);
                            }
                            else
                            {
                                msg = new MsgModel
                                {
                                    State = false,
                                    Msg = "出错了",
                                    Data = null
                                };
                            }
                        }
                        catch (Exception e)
                        {
                            msg = new MsgModel
                            {
                                State = false,
                                Msg = "出错了",
                                Data = null
                            };
                        }
                        json = WebHelper.GetObjJson(msg);
                        break;
                    }
                case "changeProjectState":
                    {
                        var id = WebHelper.GetActionInt(context, "id");
                        var state = WebHelper.GetActionStr(context, "state");
                        var sql = "update projects set state=" + state + " where id=" + id + ";";
                        var msg = new SxDal().UpdateProjectState(sql);
                        json = WebHelper.GetObjJson(msg);
                        break;
                    }
                case "getallprojects":
                    {
                        var msg = new SxDal().GetAllProjects();
                        json = WebHelper.GetObjJson(msg);
                        break;
                    }
                case "GetProjects":
                    {
                        var msg = new SxDal().GetProjects();
                        json = WebHelper.GetObjJson(msg);
                        break;
                    }
                case "GetBuildings":
                    {
                        var msg = new SxDal().GetBuildings();
                        json = WebHelper.GetObjJson(msg);
                        break;
                    }
                case "SecurityQuestionForm":
                    {
                        var projectid = WebHelper.GetActionInt(context, "projectid");
                        var projectname = WebHelper.GetActionStr(context, "projectname");
                        var buildingno = WebHelper.GetActionStr(context, "buildingno");
                        var levelno = WebHelper.GetActionStr(context, "levelno");
                        var location = WebHelper.GetActionStr(context, "location");
                        var details = WebHelper.GetActionStr(context, "details");
                        var checktime = WebHelper.GetActionStr(context, "checktime");
                        var workers = WebHelper.GetActionStr(context, "workers");
                        var managers = WebHelper.GetActionStr(context, "managers");
                        var results = WebHelper.GetActionStr(context, "results");
                        var reworkers = WebHelper.GetActionStr(context, "reworkers");
                        var finishtime = WebHelper.GetActionStr(context, "finishtime");
                        var costofworktime = WebHelper.GetActionStr(context, "costofworktime");
                        var costofmaterial = WebHelper.GetActionStr(context, "costofmaterial");
                        var rechecker = WebHelper.GetActionStr(context, "rechecker");
                        if (um != null)
                        {
                            var sql =
                                "INSERT INTO PROBLEMS(projectid,projectname,buildingno,levelno,location,problemdescription,responsibleperson,checkdate,worker,rebuilder,finishdate,rechecker,treatmentmeasures,worktimecost,materialcost,problemType,poster,posttime) VALUES(" +
                                projectid + ",'" + projectname + "','" + buildingno + "','" + levelno + "','" + location +
                                "','" + details + "','" + managers + "','" + checktime + "','" + workers + "','" + reworkers +
                                "','" + finishtime + "','" + rechecker + "','" + results + "','" + costofworktime + "','" +
                                costofmaterial + "','Security','" + um.RealName + "','" +
                                DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "')";
                            var msg = new SxDal().AddData(sql);
                            json = WebHelper.GetObjJson(msg);
                        }
                        break;
                    }
                case "QualityQuestionForm":
                    {
                        var projectid = WebHelper.GetActionInt(context, "projectid");
                        var projectname = WebHelper.GetActionStr(context, "projectname");
                        var buildingno = WebHelper.GetActionStr(context, "buildingno");
                        var levelno = WebHelper.GetActionStr(context, "levelno");
                        var location = WebHelper.GetActionStr(context, "location");
                        var details = WebHelper.GetActionStr(context, "details");
                        var checktime = WebHelper.GetActionStr(context, "checktime");
                        var workers = WebHelper.GetActionStr(context, "workers");
                        var managers = WebHelper.GetActionStr(context, "managers");
                        var results = WebHelper.GetActionStr(context, "results");
                        var reworkers = WebHelper.GetActionStr(context, "reworkers");
                        var finishtime = WebHelper.GetActionStr(context, "finishtime");
                        var costofworktime = WebHelper.GetActionStr(context, "costofworktime");
                        var costofmaterial = WebHelper.GetActionStr(context, "costofmaterial");
                        var rechecker = WebHelper.GetActionStr(context, "rechecker");
                        if (um != null)
                        {
                            var sql =
                                "INSERT INTO PROBLEMS(projectid,projectname,buildingno,levelno,location,problemdescription,responsibleperson,checkdate,worker,rebuilder,finishdate,rechecker,treatmentmeasures,worktimecost,materialcost,problemType,poster,posttime) VALUES(" +
                                projectid + ",'" + projectname + "','" + buildingno + "','" + levelno + "','" + location +
                                "','" + details + "','" + managers + "','" + checktime + "','" + workers + "','" + reworkers +
                                "','" + finishtime + "','" + rechecker + "','" + results + "','" + costofworktime + "','" +
                                costofmaterial + "','Quality','" + um.RealName + "','" +
                                DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "')";
                            var msg = new SxDal().AddData(sql);
                            json = WebHelper.GetObjJson(msg);
                        }
                        break;
                    }
                case "LaborCostForm":
                    {
                        var projectid = WebHelper.GetActionInt(context, "projectid");
                        var projectname = WebHelper.GetActionStr(context, "projectname");
                        var buildingno = WebHelper.GetActionStr(context, "buildingno");
                        var startdate = WebHelper.GetActionStr(context, "startdate");
                        var enddate = WebHelper.GetActionStr(context, "enddate");
                        var content = WebHelper.GetActionStr(context, "content");
                        var workcontent = WebHelper.GetActionStr(context, "workcontent");
                        var unit = WebHelper.GetActionStr(context, "unit");
                        var price = WebHelper.GetActionStr(context, "price");
                        var number = WebHelper.GetActionStr(context, "number");
                        var totalprice = WebHelper.GetActionStr(context, "totalprice");
                        var remark = WebHelper.GetActionStr(context, "remark");
                        if (um != null)
                        {
                            var sql =
                                "INSERT INTO cost_labor(projectid,projectname,buildingno,startdate,endate,content,workcontent,unit,price,worktime,totalprice,remark,poster,posttime,state) VALUES(" +
                                projectid + ",'" + projectname + "','" + buildingno + "','" + startdate + "','" + enddate + "','" + content + "','" + workcontent + "','" + unit + "'," + price + "," + number +
                                "," + totalprice + ",'" + remark + "','" + um.RealName + "','" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "',1)";
                            var msg = new SxDal().AddData(sql);
                            json = WebHelper.GetObjJson(msg);
                        }
                        break;
                    }
                case "ManageCostForm":
                    {
                        var projectid = WebHelper.GetActionInt(context, "projectid");
                        var projectname = WebHelper.GetActionStr(context, "projectname");
                        var curdate = WebHelper.GetActionStr(context, "curdate");
                        var type = WebHelper.GetActionStr(context, "type");
                        var content = WebHelper.GetActionStr(context, "content");
                        var unit = WebHelper.GetActionStr(context, "unit");
                        var price = WebHelper.GetActionStr(context, "price");
                        var number = WebHelper.GetActionStr(context, "number");
                        var totalprice = WebHelper.GetActionStr(context, "totalprice");
                        var remark = WebHelper.GetActionStr(context, "remark");
                        if (um != null)
                        {
                            var sql =
                                 "INSERT INTO cost_management(projectid,projectname,curdate,type,content,unit,price,number,totalprice,remark,poster,posttime) VALUES(" +
                                 projectid + ",'" + projectname + "','" + curdate + "','" + type + "','" + content + "','" + unit + "'," + price + "," + number +
                                 "," + totalprice + ",'" + remark + "','" + um.RealName + "','" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "',1)";
                            var msg = new SxDal().AddData(sql);
                            json = WebHelper.GetObjJson(msg);
                        }
                        break;
                    }
                case "MaterialCostForm":
                    {
                        var projectid = WebHelper.GetActionInt(context, "projectid");
                        var projectname = WebHelper.GetActionStr(context, "projectname");
                        var buildingno = WebHelper.GetActionStr(context, "buildingno");
                        var curdate = WebHelper.GetActionStr(context, "curdate");
                        var workteam = WebHelper.GetActionStr(context, "workteam");
                        var content = WebHelper.GetActionStr(context, "content");
                        var unit = WebHelper.GetActionStr(context, "unit");
                        var price = WebHelper.GetActionStr(context, "price");
                        var number = WebHelper.GetActionStr(context, "number");
                        var totalprice = WebHelper.GetActionStr(context, "totalprice");
                        var remark = WebHelper.GetActionStr(context, "remark");
                        if (um != null)
                        {
                            var sql =
                                "INSERT INTO cost_material(projectid,projectname,buildingno,curdate,workteam,materialname,unit,price,number,totalprice,remark,poster,posttime) VALUES(" +
                                projectid + ",'" + projectname + "','" + buildingno + "','" + curdate + "','" + workteam + "','" + content + "','" + unit + "'," + price + "," + number + "," + totalprice +
                                ",'" + remark + "','" + um.RealName + "','" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "')";
                            var msg = new SxDal().AddData(sql);
                            json = WebHelper.GetObjJson(msg);
                        }
                        break;
                    }
                case "GetSercurityProblems":
                    {
                        var projectid = WebHelper.GetActionInt(context, "ProjectId");
                        var month = WebHelper.GetActionStr(context, "month");
                        if (projectid > 0)
                        {
                            var sql = string.IsNullOrEmpty(month)
                                ? "SELECT * FROM Problems a where a.problemType='Security' and a.projectid=" + projectid
                                : "SELECT * FROM Problems A WHERE  a.problemType='Security'  and A.projectid=" + projectid + " and a.checkdate>='" + month + "-01" + "'  and a.checkdate<'" + (Convert.ToDateTime(month + "-01").AddMonths(1).ToString("yyyy-MM-dd")) + "'";
                            var result = new SxDal().GetProblems(sql);
                            json = WebHelper.GetObjJson(result);
                        }
                        break;
                    }
                case "GetQualityProblems":
                    {
                        var projectid = WebHelper.GetActionInt(context, "ProjectId");
                        var month = WebHelper.GetActionStr(context, "month");
                        if (projectid > 0)
                        {
                            var sql = string.IsNullOrEmpty(month)
                                ? "SELECT * FROM Problems a where a.problemType='Quality' and a.projectid=" + projectid
                                : "SELECT * FROM Problems A WHERE  a.problemType='Quality'  and A.projectid=" + projectid + " and a.checkdate>='" + month + "-01" + "'  and a.checkdate<'" + (Convert.ToDateTime(month + "-01").AddMonths(1).ToString("yyyy-MM-dd")) + "'";
                            var result = new SxDal().GetProblems(sql);
                            json = WebHelper.GetObjJson(result);
                        }
                        break;
                    }
                case "GetLaborCosts":
                    {
                        var projectid = WebHelper.GetActionInt(context, "ProjectId");
                        var month = WebHelper.GetActionStr(context, "month");
                        if (projectid > 0)
                        {
                            var sql = string.IsNullOrEmpty(month)
                                ? "SELECT * FROM cost_labor a where  a.projectid=" + projectid
                                : "SELECT * FROM cost_labor A WHERE A.projectid=" + projectid + " and a.startdate>='" + month + "-01" + "'  and a.startdate<'" + (Convert.ToDateTime(month + "-01").AddMonths(1).ToString("yyyy-MM-dd")) + "'";
                            var result = new SxDal().GetProblems(sql);
                            json = WebHelper.GetObjJson(result);
                        }
                        break;
                    }
                case "GetMaterialCosts":
                    {
                        var projectid = WebHelper.GetActionInt(context, "ProjectId");
                        var month = WebHelper.GetActionStr(context, "month");
                        if (projectid > 0)
                        {
                            var sql = string.IsNullOrEmpty(month)
                                ? "SELECT * FROM cost_material a where a.projectid=" + projectid
                                : "SELECT * FROM cost_material A WHERE A.projectid=" + projectid + " and a.curdate>='" + month + "-01" + "'  and a.curdate<'" + (Convert.ToDateTime(month + "-01").AddMonths(1).ToString("yyyy-MM-dd")) + "'";
                            var result = new SxDal().GetProblems(sql);
                            json = WebHelper.GetObjJson(result);
                        }
                        break;
                    }
                case "GetManageCosts":
                    {
                        var projectid = WebHelper.GetActionInt(context, "ProjectId");
                        var month = WebHelper.GetActionStr(context, "month");
                        if (projectid > 0)
                        {
                            var sql = string.IsNullOrEmpty(month)
                                ? "SELECT * FROM cost_management a where a.projectid=" + projectid
                                : "SELECT * FROM cost_management A WHERE  A.projectid=" + projectid + " and a.curdate>='" + month + "-01" + "'  and a.curdate<'" + (Convert.ToDateTime(month + "-01").AddMonths(1).ToString("yyyy-MM-dd")) + "'";
                            var result = new SxDal().GetProblems(sql);
                            json = WebHelper.GetObjJson(result);
                        }
                        break;
                    }
            }
            context.Response.Write(json);
        }

        public bool IsReusable
        {
            get { return false; }
        }
    }
}