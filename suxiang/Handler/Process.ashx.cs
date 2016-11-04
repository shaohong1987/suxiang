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
                case "getdata":
                {
                        var type= WebHelper.GetActionStr(context, "type");
                        var formid = WebHelper.GetActionStr(context, "formid");
                        var sql = "select * from "+type+" where id="+formid;
                        var msg = new SxDal().GetData(sql);
                        json = WebHelper.GetObjJson(msg);
                        break;
                    }
                case "doRemark":
                    {
                        var type = WebHelper.GetActionStr(context, "type");
                        var formid = WebHelper.GetActionStr(context, "formid");
                        break;
                }
                case "doSummary":
                    {
                        var type = WebHelper.GetActionStr(context, "type");
                        var formid = WebHelper.GetActionStr(context, "formid");
                        break;
                }
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
                            var productleader = WebHelper.GetActionStr(context, "productleader");
                            var accountant = WebHelper.GetActionStr(context, "accountant");
                            var constructionleader = WebHelper.GetActionStr(context, "constructionleader");
                            var qualityleader = WebHelper.GetActionStr(context, "qualityleader");
                            var safetyleader = WebHelper.GetActionStr(context, "safetyleader");
                            var storekeeper = WebHelper.GetActionStr(context, "storekeeper");

                            var marr = manage.Split('-');
                            var parr = productleader.Split('-');
                            var aarr = accountant.Split('-');
                            var carr = constructionleader.Split('-');
                            var qarr = qualityleader.Split('-');
                            var saarr = safetyleader.Split('-');
                            var starr = storekeeper.Split('-');

                            var list = (from string item in context.Request.Params where item.StartsWith("bArr") select context.Request.Params[item] into v select v.Split(',')).ToList();
                            var sql = "update projects set projectname='" + projectname
                                + "',projectleaderid=" + marr[0]
                                + ",projectleader='" + marr[1]
                                + "',productleaderid=" + parr[0]
                                + ",productleader='" + parr[1]
                                + "',accountantid=" + aarr[0]
                                + ",accountant='" + aarr[1]
                                + "',constructionleaderid=" + carr[0]
                                + ",constructionleader='" + carr[1]
                                + "',qualityleaderid=" + qarr[0]
                                + ",qualityleader='" + qarr[1]
                                + "',safetyleaderid=" + saarr[0]
                                + ",safetyleader='" + saarr[1]
                                + "',storekeeperid=" + starr[0]
                                + ",storekeeper='" + starr[1]
                                + "',buildingTotal=" + list.Count + " where id=" + projectid + ";";
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
                            var productleader = WebHelper.GetActionStr(context, "productleader");
                            var accountant = WebHelper.GetActionStr(context, "accountant");
                            var constructionleader = WebHelper.GetActionStr(context, "constructionleader");
                            var qualityleader = WebHelper.GetActionStr(context, "qualityleader");
                            var safetyleader = WebHelper.GetActionStr(context, "safetyleader");
                            var storekeeper = WebHelper.GetActionStr(context, "storekeeper");

                            var marr = manage.Split('-');
                            var parr = productleader.Split('-');
                            var aarr = accountant.Split('-');
                            var carr = constructionleader.Split('-');
                            var qarr = qualityleader.Split('-');
                            var saarr = safetyleader.Split('-');
                            var starr = storekeeper.Split('-');

                            var list = (from string item in context.Request.Params where item.StartsWith("bArr") select context.Request.Params[item] into v select v.Split(',')).ToList();
                            var sql = "insert into projects(projectname,projectleaderid,projectleader,productleaderid,productleader,accountantid,accountant,constructionleaderid,constructionleader,safetyleaderid,safetyleader,qualityleaderid,qualityleader,storekeeperid,storekeeper,buildingTotal,state)values('" + projectname + "'," + marr[0] + ",'" + marr[1] + "'," + parr[0] + ",'" + parr[1] + "'," + aarr[0] + ",'" + aarr[1] + "'," + carr[0] + ",'" + carr[1] + "'," + saarr[0] + ",'" + saarr[1] + "'," + qarr[0] + ",'" + qarr[1] + "'," + starr[0] + ",'" + starr[1] + "'," + list.Count + ",1);select @@identity;";
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
                        var levelno = WebHelper.GetActionStr(context, "levelno");
                        var projectid = WebHelper.GetActionInt(context, "projectid");
                        var projectname = WebHelper.GetActionStr(context, "projectname");
                        var buildingno = WebHelper.GetActionStr(context, "buildingno");
                        var location = WebHelper.GetActionStr(context, "location");
                        var checkdate = WebHelper.GetActionStr(context, "checkdate");
                        var finishdate = WebHelper.GetActionStr(context, "finishdate");
                        var problemdescription = WebHelper.GetActionStr(context, "problemdescription");
                        var causation = WebHelper.GetActionStr(context, "causation");
                        var teamleaderid = -1;
                        var teamleader = WebHelper.GetActionStr(context, "teamleader");//fffff
                        var worker = WebHelper.GetActionStr(context, "worker");
                        var responsibleperson1 = WebHelper.GetActionStr(context, "responsibleperson1");
                        var responsibleperson2 = WebHelper.GetActionStr(context, "responsibleperson2");
                        var rebuildsolution = WebHelper.GetActionStr(context, "rebuildsolution");
                        var rebuilder = WebHelper.GetActionStr(context, "rebuilder");
                        var treatmentmeasures = WebHelper.GetActionStr(context, "treatmentmeasures");
                        var worktimecostDb = WebHelper.GetActionStr(context, "worktimecost_db");
                        var worktimecostXb = WebHelper.GetActionStr(context, "worktimecost_xb");
                        var materialcost = WebHelper.GetActionStr(context, "materialcost");
                        var rechecker = WebHelper.GetActionStr(context, "rechecker");
                        if (!string.IsNullOrEmpty(teamleader) && teamleader.Contains("-"))
                        {
                            var arr = teamleader.Split('-');
                            teamleaderid = Convert.ToInt32(arr[0]);
                            teamleader = arr[1];
                        }
                        if (um != null)
                        {
                            var sql =
                                "INSERT INTO problem_sercurity(levelno,projectid,projectname,buildingno,location,checkdate," +
                                "finishdate,problemdescription,causation,teamleaderid,teamleader,worker,responsibleperson1," +
                                "responsibleperson2,rebuildsolution,rebuilder,treatmentmeasures,worktimecost_db,worktimecost_xb," +
                                "materialcost,rechecker,posterid,postername,posttime)values('"+levelno+"',"+projectid+",'"
                                +projectname+"','"
                                +buildingno+"','"
                                +location+"','"
                                +checkdate+"','"
                                +finishdate+"','"
                                +problemdescription+"','"
                                +causation+"',"
                                +teamleaderid+",'"
                                +teamleader+"','"
                                +worker+"','"
                                +responsibleperson1+"','"
                                +responsibleperson2+"','"
                                +rebuildsolution+"','"
                                +rebuilder+"','"
                                +treatmentmeasures+"','"
                                +worktimecostDb+"','"
                                +worktimecostXb+"','"
                                +materialcost+"','"
                                +rechecker+"','"
                                +um.Id+"','"
                                +um.RealName+"','"
                                +DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")+"'); ";
                            var msg = new SxDal().AddData(sql);
                            json = WebHelper.GetObjJson(msg);
                        }
                        break;
                    }
                case "QualityQuestionForm":
                    {
                        var levelno = WebHelper.GetActionStr(context, "levelno");
                        var projectid = WebHelper.GetActionInt(context, "projectid");
                        var projectname = WebHelper.GetActionStr(context, "projectname");
                        var buildingno = WebHelper.GetActionStr(context, "buildingno");
                        var location = WebHelper.GetActionStr(context, "location");
                        var checkdate = WebHelper.GetActionStr(context, "checkdate");
                        var finishdate = WebHelper.GetActionStr(context, "finishdate");
                        var problemdescription = WebHelper.GetActionStr(context, "problemdescription");
                        var causation = WebHelper.GetActionStr(context, "causation");
                        var teamleaderid = -1;
                        var teamleader = WebHelper.GetActionStr(context, "teamleader");//fffff
                        var worker = WebHelper.GetActionStr(context, "worker");
                        var responsibleperson1 = WebHelper.GetActionStr(context, "responsibleperson1");
                        var responsibleperson2 = WebHelper.GetActionStr(context, "responsibleperson2");
                        var rebuildsolution = WebHelper.GetActionStr(context, "rebuildsolution");
                        var rebuilder = WebHelper.GetActionStr(context, "rebuilder");
                        var treatmentmeasures = WebHelper.GetActionStr(context, "treatmentmeasures");
                        var worktimecostDb = WebHelper.GetActionStr(context, "worktimecost_db");
                        var worktimecostXb = WebHelper.GetActionStr(context, "worktimecost_xb");
                        var materialcost = WebHelper.GetActionStr(context, "materialcost");
                        var rechecker = WebHelper.GetActionStr(context, "rechecker");
                        if (!string.IsNullOrEmpty(teamleader) && teamleader.Contains("-"))
                        {
                            var arr = teamleader.Split('-');
                            teamleaderid = Convert.ToInt32(arr[0]);
                            teamleader = arr[1];
                        }
                        if (um != null)
                        {
                            var sql =
                                "INSERT INTO problem_quality(levelno,projectid,projectname,buildingno,location,checkdate," +
                                "finishdate,problemdescription,causation,teamleaderid,teamleader,worker,responsibleperson1," +
                                "responsibleperson2,rebuildsolution,rebuilder,treatmentmeasures,worktimecost_db,worktimecost_xb," +
                                "materialcost,rechecker,posterid,postername,posttime)values('" + levelno + "'," + projectid + ",'"
                                + projectname + "','"
                                + buildingno + "','"
                                + location + "','"
                                + checkdate + "','"
                                + finishdate + "','"
                                + problemdescription + "','"
                                + causation + "',"
                                + teamleaderid + ",'"
                                + teamleader + "','"
                                + worker + "','"
                                + responsibleperson1 + "','"
                                + responsibleperson2 + "','"
                                + rebuildsolution + "','"
                                + rebuilder + "','"
                                + treatmentmeasures + "','"
                                + worktimecostDb + "','"
                                + worktimecostXb + "','"
                                + materialcost + "','"
                                + rechecker + "','"
                                + um.Id + "','"
                                + um.RealName + "','"
                                + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "'); ";
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
                        var endate = WebHelper.GetActionStr(context, "endate");
                        var worktype = WebHelper.GetActionStr(context, "worktype");
                        var teamleaderid = -1;
                        var teamleader = WebHelper.GetActionStr(context, "teamleader");//fffff
                        var workcontent = WebHelper.GetActionStr(context, "workcontent");
                        var unit = WebHelper.GetActionStr(context, "unit");
                        var price = WebHelper.GetActionStr(context, "price");
                        var number = WebHelper.GetActionStr(context, "number");
                        var totalprice = WebHelper.GetActionStr(context, "totalprice");
                        var remarkbywork = WebHelper.GetActionStr(context, "remarkbywork");
                        if (!string.IsNullOrEmpty(teamleader) && teamleader.Contains("-"))
                        {
                            var arr = teamleader.Split('-');
                            teamleaderid = Convert.ToInt32(arr[0]);
                            teamleader = arr[1];
                        }
                        if (um != null)
                        {
                            var sql =
                                "INSERT INTO cost_labor(projectid,projectname,buildingno,startdate,endate,worktype,teamleaderid,teamleader,workcontent,unit,price,worktime,totalprice,remarkbywork,postid,poster,posttime,state) VALUES(" +
                                projectid + ",'" + projectname + "','" + buildingno + "','" + startdate + "','" + endate + "','" + worktype + "',"+teamleaderid+",'"+teamleader+"','" + workcontent + "','" + unit + "'," + price + "," + number +
                                "," + totalprice + ",'" + remarkbywork + "',"+um.Id+",'" + um.RealName + "','" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "',1);";
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
                        var remarkbyaccount = WebHelper.GetActionStr(context, "remarkbyaccount");
                        if (um != null)
                        {
                            var sql =
                                 "INSERT INTO cost_management(projectid,projectname,curdate,type,content,unit,price,number,totalprice,remarkbyaccount,postid,poster,posttime) VALUES(" +
                                 projectid + ",'" + projectname + "','" + curdate + "','" + type + "','" + content + "','" + unit + "'," + price + "," + number +
                                 "," + totalprice + ",'" + remarkbyaccount + "',"+um.Id+",'" + um.RealName + "','" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "');";
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
                        var teamleaderid = -1;
                        var teamleader = WebHelper.GetActionStr(context, "teamleader");
                        var materialname = WebHelper.GetActionStr(context, "materialname");
                        var unit = WebHelper.GetActionStr(context, "unit");
                        var price = WebHelper.GetActionStr(context, "price");
                        var number = WebHelper.GetActionStr(context, "number");
                        var totalprice = WebHelper.GetActionStr(context, "totalprice");
                        var remarkbyworker = WebHelper.GetActionStr(context, "remarkbyworker");
                        if (!string.IsNullOrEmpty(teamleader) && teamleader.Contains("-"))
                        {
                            var arr = teamleader.Split('-');
                            teamleaderid = Convert.ToInt32(arr[0]);
                            teamleader = arr[1];
                        }
                        if (um != null)
                        {
                            var sql =
                                "INSERT INTO cost_material(projectid,projectname,buildingno,curdate,teamleaderid,teamleader,materialname,unit,price,number,totalprice,remarkbyworker,postid,poster,posttime) VALUES(" +
                                projectid + ",'" + projectname + "','" + buildingno + "','" + curdate + "',"+ teamleaderid+ ",'" + teamleader + "','" + materialname + "','" + unit + "'," + price + "," + number + "," + totalprice +
                                ",'" + remarkbyworker + "',"+um.Id+",'" + um.RealName + "','" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "')";
                            var msg = new SxDal().AddData(sql);
                            json = WebHelper.GetObjJson(msg);
                        }
                        break;
                    }
                case "MaterialAuxiliaryCostForm":
                {
                        var projectid = WebHelper.GetActionInt(context, "projectid");
                        var projectname = WebHelper.GetActionStr(context, "projectname");
                        var buildingno = WebHelper.GetActionStr(context, "buildingno");
                        var curdate = WebHelper.GetActionStr(context, "curdate");
                        var teamleaderid = -1;
                        var teamleader = WebHelper.GetActionStr(context, "teamleader");
                        var materialname = WebHelper.GetActionStr(context, "materialname");
                        var unit = WebHelper.GetActionStr(context, "unit");
                        var price = WebHelper.GetActionStr(context, "price");
                        var number = WebHelper.GetActionStr(context, "number");
                        var totalprice = WebHelper.GetActionStr(context, "totalprice");
                        var remarkbyworker = WebHelper.GetActionStr(context, "remarkbyworker");
                        if (!string.IsNullOrEmpty(teamleader) && teamleader.Contains("-"))
                        {
                            var arr = teamleader.Split('-');
                            teamleaderid = Convert.ToInt32(arr[0]);
                            teamleader = arr[1];
                        }
                        if (um != null)
                        {
                            var sql =
                                "INSERT INTO cost_materialauxiliary(projectid,projectname,buildingno,curdate,teamleaderid,teamleader,materialname,unit,price,number,totalprice,remarkbyworker,postid,poster,posttime) VALUES(" +
                                projectid + ",'" + projectname + "','" + buildingno + "','" + curdate + "'," + teamleaderid + ",'" + teamleader + "','" + materialname + "','" + unit + "'," + price + "," + number + "," + totalprice +
                                ",'" + remarkbyworker + "'," + um.Id + ",'" + um.RealName + "','" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "')";
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
                                ? "SELECT id,projectid,projectname,buildingno,levelno,location,problemdescription,responsibleperson,DATE_FORMAT(`checkdate`,'%Y-%m-%d') as checkdate,worker,rebuilder,DATE_FORMAT(`finishdate`,'%Y-%m-%d') as finishdate,rechecker,treatmentmeasures,worktimecost,materialcost,problemType,poster,DATE_FORMAT(`posttime`,'%Y-%m-%d') as posttime FROM Problems a where a.problemType='Security' and a.projectid=" + projectid
                                : "SELECT id,projectid,projectname,buildingno,levelno,location,problemdescription,responsibleperson,DATE_FORMAT(`checkdate`,'%Y-%m-%d') as checkdate,worker,rebuilder,DATE_FORMAT(`finishdate`,'%Y-%m-%d') as finishdate,rechecker,treatmentmeasures,worktimecost,materialcost,problemType,poster,DATE_FORMAT(`posttime`,'%Y-%m-%d') as posttime FROM Problems A WHERE  a.problemType='Security'  and A.projectid=" + projectid + " and a.checkdate>='" + month + "-01" + "'  and a.checkdate<'" + (Convert.ToDateTime(month + "-01").AddMonths(1).ToString("yyyy-MM-dd")) + "'";
                            var result = new SxDal().GetData(sql);
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
                                ? "SELECT id,projectid,projectname,buildingno,levelno,location,problemdescription,responsibleperson,DATE_FORMAT(`checkdate`,'%Y-%m-%d') as checkdate,worker,rebuilder,DATE_FORMAT(`finishdate`,'%Y-%m-%d') as finishdate,rechecker,treatmentmeasures,worktimecost,materialcost,problemType,poster,DATE_FORMAT(`posttime`,'%Y-%m-%d') as posttime FROM Problems a where a.problemType='Quality' and a.projectid=" + projectid
                                : "SELECT id,projectid,projectname,buildingno,levelno,location,problemdescription,responsibleperson,DATE_FORMAT(`checkdate`,'%Y-%m-%d') as checkdate,worker,rebuilder,DATE_FORMAT(`finishdate`,'%Y-%m-%d') as finishdate,rechecker,treatmentmeasures,worktimecost,materialcost,problemType,poster,DATE_FORMAT(`posttime`,'%Y-%m-%d') as posttime FROM Problems A WHERE  a.problemType='Quality'  and A.projectid=" + projectid + " and a.checkdate>='" + month + "-01" + "'  and a.checkdate<'" + (Convert.ToDateTime(month + "-01").AddMonths(1).ToString("yyyy-MM-dd")) + "'";
                            var result = new SxDal().GetData(sql);
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
                               ? "SELECT id,projectid,projectname,buildingno,DATE_FORMAT(`startdate`,'%Y-%m-%d') as startdate,DATE_FORMAT(`endate`,'%Y-%m-%d') as endate,content,workcontent,unit,price,worktime,totalprice,poster,posttime,state,remark FROM cost_labor a where  a.projectid=" +
                                 projectid
                               : "SELECT id,projectid,projectname,buildingno,DATE_FORMAT(`startdate`,'%Y-%m-%d') as startdate,DATE_FORMAT(`endate`,'%Y-%m-%d') as endate,content,workcontent,unit,price,worktime,totalprice,poster,posttime,state,remark FROM cost_labor A WHERE A.projectid=" +
                                 projectid + " and a.startdate>='" + month + "-01" + "'  and a.startdate<'" +
                                 (Convert.ToDateTime(month + "-01").AddMonths(1).ToString("yyyy-MM-dd")) + "'";
                            var result = new SxDal().GetData(sql);
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
                               ? "SELECT id,projectid,projectname,buildingno,DATE_FORMAT(`curdate`,'%Y-%m-%d') as curdate,workteam,materialname,unit,number,price,totalprice,remark,poster,posttime FROM cost_material a where a.projectid=" + projectid
                               : "SELECT id,projectid,projectname,buildingno,DATE_FORMAT(`curdate`,'%Y-%m-%d') as curdate,workteam,materialname,unit,number,price,totalprice,remark,poster,posttime FROM cost_material A WHERE A.projectid=" + projectid + " and a.curdate>='" + month + "-01" + "'  and a.curdate<'" + (Convert.ToDateTime(month + "-01").AddMonths(1).ToString("yyyy-MM-dd")) + "'";
                            var result = new SxDal().GetData(sql);
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
                                ? "SELECT id,projectid,projectname,DATE_FORMAT(`curdate`,'%Y-%m-%d') as curdate,type,content,unit,number,price,totalprice,remark,poster,posttime FROM cost_management a where a.projectid=" + projectid
                                : "SELECT id,projectid,projectname,DATE_FORMAT(`curdate`,'%Y-%m-%d') as curdate,type,content,unit,number,price,totalprice,remark,poster,posttime FROM cost_management A WHERE  A.projectid=" + projectid + " and a.curdate>='" + month + "-01" + "'  and a.curdate<'" + (Convert.ToDateTime(month + "-01").AddMonths(1).ToString("yyyy-MM-dd")) + "'";
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