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
                        var question = new QuestionModel
                        {
                            Projectid = projectid,
                            Projectname = projectname,
                            BuildingNo = buildingno,
                            Checkdate = checktime,
                            Finishdate = finishtime,
                            Levelno = levelno,
                            Location = location,
                            Materialcost = costofmaterial,
                            Problemdescription = details,
                            Responsibleperson = managers,
                            Worker = workers,
                            Treatmentmeasures = results,
                            Rebuilder = reworkers,
                            Rechecker = rechecker,
                            Worktimecost = costofworktime,
                            Poster = um.RealName,
                            Posttime = DateTime.Now,
                            ProblemType = "Security"
                        };
                        var sql = string.Format("");
                        var msg = new SxDal().AddData(sql);
                        json = WebHelper.GetObjJson(msg);
                    }
                    break;
                }
                case "QualityQuestionForm":
                {
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