using System;
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
                um = (UsersModel) context.Session["user"];
            else
                context.Response.Redirect("~/Login.aspx");
            switch (action)
            {
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
                    var checktime = WebHelper.GetActionDt(context, "checktime");
                    var workers = WebHelper.GetActionStr(context, "workers");
                    var managers = WebHelper.GetActionStr(context, "managers");
                    var results = WebHelper.GetActionStr(context, "results");
                    var reworkers = WebHelper.GetActionStr(context, "reworkers");
                    var finishtime = WebHelper.GetActionDt(context, "finishtime");
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
                            costofmaterial + "','Security','"+um.RealName+",'"+DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")+"')";
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
                        var checktime = WebHelper.GetActionDt(context, "checktime");
                        var workers = WebHelper.GetActionStr(context, "workers");
                        var managers = WebHelper.GetActionStr(context, "managers");
                        var results = WebHelper.GetActionStr(context, "results");
                        var reworkers = WebHelper.GetActionStr(context, "reworkers");
                        var finishtime = WebHelper.GetActionDt(context, "finishtime");
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
                            costofmaterial + "','Quality','" + um.RealName + ",'" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "')";
                            var msg = new SxDal().AddData(sql);
                            json = WebHelper.GetObjJson(msg);
                        }
                        break;
                    }
                case "LaborCostForm":
                {
                    break;
                }
                case "ManageCostForm":
                {
                    break;
                }
                case "MaterialCostForm":
                {
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