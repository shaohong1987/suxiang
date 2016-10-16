using System;
using System.Web;
using System.Web.SessionState;
using suxiang.mobile.Dal;
using suxiang.mobile.Helper;
using suxiang.Model;

namespace suxiang.mobile.Handler
{
    /// <summary>
    ///     process 的摘要说明
    /// </summary>
    public class Process : IHttpHandler, IRequiresSessionState
    {
        public void ProcessRequest(HttpContext context)
        {
            UsersModel um = null;
            if (context.Session["user"] != null)
                um = (UsersModel)context.Session["user"];
            else
                context.Response.Redirect("~/login.htm");
            var json = "";
            var action = WebHelper.GetActionStr(context, "action");
            switch (action)
            {
                case "updatepwdaction":
                    {
                        var oldpass = WebHelper.GetActionStr(context, "oldpass");
                        var newpass = WebHelper.GetActionStr(context, "newpass");
                        var sql = "update users set `password`='" + newpass + "' where username='" + um.EmployeeNo + "' and `password`='" + oldpass + "';";
                        var msg = new SxDal().UpdatePwd(sql);
                        json = WebHelper.GetObjJson(msg);
                        if (msg.Data != null)
                            context.Session["user"] = null;
                        break;
                    }
                case "GetBuildings":
                    {
                        var msg = new SxDal().GetBuildings();
                        json = WebHelper.GetObjJson(msg);
                        break;
                    }
                case "GetProjects":
                    {
                        var msg = new SxDal().GetProjects();
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
                                "," + totalprice + ",'" + remark + "','" + um.RealName + "','" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "',1);";
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
                                 "," + totalprice + ",'" + remark + "','" + um.RealName + "','" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "');";
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
                        var projectid = WebHelper.GetActionInt(context, "pid");
                        var startdate = WebHelper.GetActionStr(context, "sdate");
                        var enddate = WebHelper.GetActionStr(context, "edate");
                        if (projectid > 0)
                        {
                            var sql = "SELECT id,projectid,projectname,buildingno,levelno,location,problemdescription,responsibleperson,DATE_FORMAT(`checkdate`,'%Y-%m-%d') as checkdate,worker,rebuilder,DATE_FORMAT(`finishdate`,'%Y-%m-%d') as finishdate,rechecker,treatmentmeasures,worktimecost,materialcost,problemType,poster,DATE_FORMAT(`posttime`,'%Y-%m-%d') as posttime FROM Problems A WHERE  a.problemType='Security'  and A.projectid=" + projectid + " and a.checkdate>='" + startdate + "'  and a.checkdate<='" + enddate + "'";
                            var result = new SxDal().GetData(sql);
                            json = WebHelper.GetObjJson(result);
                        }
                        break;
                    }
                case "GetQualityProblems":
                    {
                        var projectid = WebHelper.GetActionInt(context, "pid");
                        var startdate = WebHelper.GetActionStr(context, "sdate");
                        var enddate = WebHelper.GetActionStr(context, "edate");
                        if (projectid > 0)
                        {
                            var sql = "SELECT id,projectid,projectname,buildingno,levelno,location,problemdescription,responsibleperson,DATE_FORMAT(`checkdate`,'%Y-%m-%d') as checkdate,worker,rebuilder,DATE_FORMAT(`finishdate`,'%Y-%m-%d') as finishdate,rechecker,treatmentmeasures,worktimecost,materialcost,problemType,poster,DATE_FORMAT(`posttime`,'%Y-%m-%d') as posttime FROM Problems A WHERE  a.problemType='Quality'  and A.projectid=" + projectid + " and a.checkdate>='" + startdate + "'  and a.checkdate<='" + enddate + "'";
                            var result = new SxDal().GetData(sql);
                            json = WebHelper.GetObjJson(result);
                        }
                        break;
                    }
                case "GetLaborCosts":
                    {
                        var projectid = WebHelper.GetActionInt(context, "pid");
                        var startdate = WebHelper.GetActionStr(context, "sdate");
                        var enddate = WebHelper.GetActionStr(context, "edate");
                        if (projectid > 0)
                        {
                            var sql = "SELECT id,projectid,projectname,buildingno,DATE_FORMAT(`startdate`,'%Y-%m-%d') as startdate,DATE_FORMAT(`endate`,'%Y-%m-%d') as endate,content,workcontent,unit,price,worktime,totalprice,poster,posttime,state,remark FROM cost_labor A WHERE A.projectid=" + projectid + " and a.startdate>='" + startdate + "'  and a.startdate<='" + enddate + "'";
                            var result = new SxDal().GetData(sql);
                            json = WebHelper.GetObjJson(result);
                        }

                        break;
                    }
                case "GetMaterialCosts":
                    {
                        var projectid = WebHelper.GetActionInt(context, "pid");
                        var startdate = WebHelper.GetActionStr(context, "sdate");
                        var enddate = WebHelper.GetActionStr(context, "edate");
                        if (projectid > 0)
                        {
                            var sql = "SELECT id,projectid,projectname,buildingno,DATE_FORMAT(`curdate`,'%Y-%m-%d') as curdate,workteam,materialname,unit,number,price,totalprice,remark,poster,posttime FROM cost_material A WHERE A.projectid=" + projectid + " and a.curdate>='" + startdate + "'  and a.curdate<='" + enddate + "'";
                            var result = new SxDal().GetData(sql);
                            json = WebHelper.GetObjJson(result);
                        }
                        break;
                    }
                case "GetManageCosts":
                    {
                        var projectid = WebHelper.GetActionInt(context, "pid");
                        var startdate = WebHelper.GetActionStr(context, "sdate");
                        var enddate = WebHelper.GetActionStr(context, "edate");
                        if (projectid > 0)
                        {
                            var sql = "SELECT id,projectid,projectname,DATE_FORMAT(`curdate`,'%Y-%m-%d') as curdate,type,content,unit,number,price,totalprice,remark,poster,posttime FROM cost_management A WHERE  A.projectid=" + projectid + " and a.curdate>='" + startdate + "'  and a.curdate<='" + enddate + "'";
                            var result = new SxDal().GetData(sql);
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