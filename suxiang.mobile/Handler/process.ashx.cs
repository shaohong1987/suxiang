using System;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using suxiang.Dal;
using suxiang.mobile.Helper;
using suxiang.Model;

namespace suxiang.mobile.Handler
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
                context.Response.Redirect("~/login.htm");
            switch (action)
            {
                case "doMaterialCostUpdate":
                    {
                        var formId = WebHelper.GetActionInt(context, "formId");
                        var projectid = WebHelper.GetActionInt(context, "projectid");
                        var curdate = WebHelper.GetActionStr(context, "curdate");
                        var materialname = WebHelper.GetActionStr(context, "materialname");
                        var unit = WebHelper.GetActionStr(context, "unit");
                        var price = WebHelper.GetActionStr(context, "price");
                        var number = WebHelper.GetActionStr(context, "number");
                        var totalprice = WebHelper.GetActionStr(context, "totalprice");
                        var remarkbyworker = WebHelper.GetActionStr(context, "remarkbyworker");
                        var teamleaderid = WebHelper.GetActionStr(context, "teamleaderid");
                        if (um != null)
                        {
                            var nextStep = SxDal.GetNextStep(projectid, -1, "cost_material", 4);
                            if (nextStep != null)
                            {
                                var sql =
                                    "update cost_material set curdate='" + curdate
                                    + "',materialname='" + materialname
                                    + "',unit='" + unit
                                    + "',price='" + price
                                    + "',number='" + number
                                    + "',totalprice='" + totalprice
                                    + "',remarkbyworker='" + remarkbyworker
                                    + "',currentUser=" + teamleaderid
                                    + ",currentPage='" + nextStep.CurrentPage
                                    + "',status='" + nextStep.Status
                                    + "',state=" + nextStep.State + " where id=" + formId;
                                var msg = new SxDal().AddData(sql);
                                json = WebHelper.GetObjJson(msg);
                            }
                        }
                        break;
                    }
                case "doMaterialAuxiliaryCostUpdate":
                    {
                        var formId = WebHelper.GetActionInt(context, "formId");
                        var projectid = WebHelper.GetActionInt(context, "projectid");
                        var curdate = WebHelper.GetActionStr(context, "curdate");
                        var materialname = WebHelper.GetActionStr(context, "materialname");
                        var unit = WebHelper.GetActionStr(context, "unit");
                        var price = WebHelper.GetActionStr(context, "price");
                        var number = WebHelper.GetActionStr(context, "number");
                        var totalprice = WebHelper.GetActionStr(context, "totalprice");
                        var remarkbyworker = WebHelper.GetActionStr(context, "remarkbyworker");
                        var teamleaderid = WebHelper.GetActionStr(context, "teamleaderid");
                        if (um != null)
                        {
                            var nextStep = SxDal.GetNextStep(projectid, -1, "cost_materialauxiliary", 4);
                            if (nextStep != null)
                            {
                                var sql =
                                    "update cost_materialauxiliary set curdate='" + curdate
                                    + "',materialname='" + materialname
                                    + "',unit='" + unit
                                    + "',price='" + price
                                    + "',number='" + number
                                    + "',totalprice='" + totalprice
                                    + "',remarkbyworker='" + remarkbyworker
                                    + "',currentUser=" + teamleaderid
                                    + ",currentPage='" + nextStep.CurrentPage
                                    + "',status='" + nextStep.Status
                                    + "',state=" + nextStep.State + " where id=" + formId;
                                var msg = new SxDal().AddData(sql);
                                json = WebHelper.GetObjJson(msg);
                            }
                        }
                        break;
                    }
                case "doLaborCostUpdate":
                    {
                        var formId = WebHelper.GetActionInt(context, "formId");
                        var projectid = WebHelper.GetActionInt(context, "projectid");
                        var startdate = WebHelper.GetActionStr(context, "startdate");
                        var endate = WebHelper.GetActionStr(context, "endate");
                        var workcontent = WebHelper.GetActionStr(context, "workcontent");
                        var unit = WebHelper.GetActionStr(context, "unit");
                        var price = WebHelper.GetActionStr(context, "price");
                        var number = WebHelper.GetActionStr(context, "number");
                        var totalprice = WebHelper.GetActionStr(context, "totalprice");
                        var remarkbywork = WebHelper.GetActionStr(context, "remarkbywork");
                        var teamleaderid = WebHelper.GetActionStr(context, "teamleaderid");
                        if (um != null)
                        {
                            var nextStep = SxDal.GetNextStep(projectid, -1, "cost_labor", 4);
                            if (nextStep != null)
                            {
                                var sql = "update cost_labor set startdate='" + startdate
                                        + "',endate='" + endate
                                        + "',workcontent='" + workcontent
                                        + "',unit='" + unit
                                        + "',price='" + price + "',worktime='" + number
                                        + "',totalprice='" + totalprice
                                        + "',remarkbywork='" + remarkbywork
                                        + "',currentUser=" + teamleaderid
                                        + ",currentPage='" + nextStep.CurrentPage
                                        + "',status='" + nextStep.Status
                                        + "',state=" + nextStep.State
                                        + " where id=" + formId;
                                var msg = new SxDal().AddData(sql);
                                json = WebHelper.GetObjJson(msg);
                            }
                        }
                        break;
                    }
                case "GetToDoForm":
                    {
                        if (um != null)
                        {
                            #region 总经理和财务的处理
                            var sql =
                                string.Format( 
                                    "select * from ( SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth,projectname,'栋号班组用工成本表' as dtype,poster,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CASE WHEN currentUser=" +
                                    um.Id +
                                    " THEN CONCAT(currentPage,id) ELSE CONCAT('LaborCostForm_View.aspx?formId=',id) END AS url,status FROM cost_labor where  state>0 "
                                    +
                                    " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'管理成本表' as dtype,poster,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CASE WHEN currentUser=" +
                                    um.Id +
                                    " THEN CONCAT(currentPage,id) ELSE CONCAT('ManageCostForm_View.aspx?formId=',id) END AS url,status FROM cost_management where  state>0 "
                                    +
                                    " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'栋号材料成本表' as dtype,poster,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CASE WHEN currentUser=" +
                                    um.Id +
                                    " THEN CONCAT(currentPage,id) ELSE CONCAT('MaterialCostForm_View.aspx?formId=',id) END AS url,status FROM cost_material where  state>0 "
                                    +
                                    " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'栋号工具辅材成本表' as dtype,poster,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CASE WHEN currentUser=" +
                                    um.Id +
                                    " THEN CONCAT(currentPage,id) ELSE CONCAT('MaterialAuxiliaryCostForm_View.aspx?formId=',id) END AS url,status FROM cost_materialauxiliary where  state>0 "
                                    +
                                    " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'质量问题表' as dtype,postername,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CASE WHEN currentUser=" +
                                    um.Id +
                                    " THEN CONCAT(currentPage,id) ELSE CONCAT('QualityQuestionForm_View.aspx?formId=',id) END AS url,status FROM problem_quality where  state>0 "
                                    +
                                    " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'安全问题表' as dtype,postername,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CASE WHEN currentUser=" +
                                    um.Id +
                                    " THEN CONCAT(currentPage,id) ELSE CONCAT('SecurityQuestionForm_View.aspx?formId=',id) END AS url,status FROM problem_sercurity where  state>0 ) a order by posttime  ");
                            #endregion
                            #region 除总经理和财务之外的处理
                            //if (um.Group > 10&&um.Id!=11) //直接取所有表单，总经理和财务
                            //{
                            //    //第一步：取当前用户参与的项目列表
                            //    sql = string.Format(
                            //        " SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth,projectname,'栋号班组用工成本表' as dtype,poster,DATE_FORMAT(`posttime`,'%Y-%m-%d %H:%i:%s') as posttime,concat(currentPage,id) as url,status FROM cost_labor where currentUser ={0} "
                            //        +
                            //        " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'管理成本表' as dtype,poster,DATE_FORMAT(`posttime`,'%Y-%m-%d %H:%i:%s') as posttime,concat(currentPage,id) as url,status FROM cost_management where currentUser ={0} "
                            //        +
                            //        " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'栋号材料成本表' as dtype,poster,DATE_FORMAT(`posttime`,'%Y-%m-%d %H:%i:%s') as posttime,concat(currentPage,id) as url,status FROM cost_material where currentUser ={0} "
                            //        +
                            //        " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'栋号工具辅材成本表' as dtype,poster,DATE_FORMAT(`posttime`,'%Y-%m-%d %H:%i:%s') as posttime,concat(currentPage,id) as url,status FROM cost_materialauxiliary where currentUser ={0} "
                            //        +
                            //        " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'质量问题表' as dtype,postername,DATE_FORMAT(`posttime`,'%Y-%m-%d %H:%i:%s') as posttime,concat(currentPage,id) as url,status FROM problem_quality where currentUser ={0} "
                            //        +
                            //        " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'安全问题表' as dtype,postername,DATE_FORMAT(`posttime`,'%Y-%m-%d %H:%i:%s') as posttime,concat(currentPage,id) as url,status FROM problem_sercurity where currentUser ={0} ",
                            //        um.Id);
                            //}

                            #endregion

                            var result = new SxDal().GetData(sql);
                            json = WebHelper.GetObjJson(result);
                        }
                        break;
                    }
                case "GetCompleteForm":
                    {
                        if (um != null)
                        {
                            var projectid = WebHelper.GetActionInt(context, "ProjectId");
                            var month = WebHelper.GetActionStr(context, "month");
                            if (projectid > 0)
                            {
                                var sql =
                                    " SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth,projectname,'栋号班组用工成本表' as dtype,poster,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CONCAT('LaborCostForm_View.aspx?formId=',id) as url FROM cost_labor where  summaryid is not null and projectid=" +
                                    projectid + " "
                                    +
                                    " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'管理成本表' as dtype,poster,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CONCAT('ManageCostForm_View.aspx?formId=',id) as url FROM cost_management where  summaryid is not null and projectid=" +
                                    projectid + " "
                                    +
                                    " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'栋号材料成本表' as dtype,poster,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime, CONCAT('MaterialCostForm_View.aspx?formId=',id) as url FROM cost_material where  summaryid is not null and projectid=" +
                                    projectid + " "
                                    +
                                    " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'栋号工具辅材成本表' as dtype,poster,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CONCAT('MaterialAuxiliaryCostForm_View.aspx?formId=',id) as url FROM cost_materialauxiliary where  summaryid is not null and projectid=" +
                                    projectid + " "
                                    +
                                    " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'质量问题表' as dtype,postername,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CONCAT('QualityQuestionForm_View.aspx?formId=',id) as url FROM problem_quality  where  summaryid is not null and projectid=" +
                                    projectid + " "
                                    +
                                    " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'安全问题表' as dtype,postername,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CONCAT('SecurityQuestionForm_View.aspx?formId=',id) as url FROM problem_sercurity where  summaryid is not null and projectid=" +
                                    projectid + " ";

                                if (!string.IsNullOrEmpty(month))
                                {
                                    sql =
                                        " SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth,projectname,'栋号班组用工成本表' as dtype,poster,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CONCAT('LaborCostForm_View.aspx?formId=',id) as url FROM cost_labor where  summaryid is not null and projectid=" +
                                        projectid + " and posttime>'" + month + "-01' "
                                        +
                                        " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'管理成本表' as dtype,poster,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CONCAT('ManageCostForm_View.aspx?formId=',id) as url FROM cost_management where  summaryid is not null and projectid=" +
                                        projectid + " and posttime>'" + month + "-01' "
                                        +
                                        " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'栋号材料成本表' as dtype,poster,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime, CONCAT('MaterialCostForm_View.aspx?formId=',id) as url FROM cost_material where  summaryid is not null and projectid=" +
                                        projectid + " and posttime>'" + month + "-01' "
                                        +
                                        " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'栋号工具辅材成本表' as dtype,poster,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CONCAT('MaterialAuxiliaryCostForm_View.aspx?formId=',id) as url FROM cost_materialauxiliary where  summaryid is not null and projectid=" +
                                        projectid + " and posttime>'" + month + "-01' "
                                        +
                                        " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'质量问题表' as dtype,postername,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CONCAT('QualityQuestionForm_View.aspx?formId=',id) as url FROM problem_quality  where  summaryid is not null and projectid=" +
                                        projectid + " and posttime>'" + month + "-01' "
                                        +
                                        " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'安全问题表' as dtype,postername,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CONCAT('SecurityQuestionForm_View.aspx?formId=',id) as url FROM problem_sercurity where  summaryid is not null and projectid=" +
                                        projectid + " and posttime>'" + month + "-01' ";
                                }
                                if (um.Group > 10) //直接取所有表单，总经理和财务
                                {
                                    sql =
                                        " SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth,projectname,'栋号班组用工成本表' as dtype,poster,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CONCAT('LaborCostForm_View.aspx?formId=',id) as url FROM cost_labor where (postid=" +
                                        um.Id + " OR comfirmid=" + um.Id + " OR recomfirmid=" + um.Id + " OR remarkid=" +
                                        um.Id + " OR summaryid=" + um.Id + ") AND currentUser <> " + um.Id +
                                        "  and projectid=" + projectid + " "
                                        +
                                        " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'管理成本表' as dtype,poster,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CONCAT('ManageCostForm_View.aspx?formId=',id) as url FROM cost_management where (postid =" +
                                        um.Id + " OR summaryid=" + um.Id + " OR remarkid=" + um.Id +
                                        ") AND currentUser<>" +
                                        um.Id + "  and projectid=" + projectid + " "
                                        +
                                        " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'栋号材料成本表' as dtype,poster,DATE_FORMAT(`posttime`,'%Y-%m-%d %H:%i:%s') AS posttime, CONCAT('MaterialCostForm_View.aspx?formId=',id) as url FROM cost_material where (postid =" +
                                        um.Id + " OR comfirmid=" + um.Id + " OR recomfirmid=" + um.Id + " OR remarkid=" +
                                        um.Id + " OR summaryid=" + um.Id + ") AND currentUser<>" + um.Id +
                                        "  and projectid=" + projectid + " "
                                        +
                                        " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'栋号工具辅材成本表' as dtype,poster,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CONCAT('MaterialAuxiliaryCostForm_View.aspx?formId=',id) as url FROM cost_materialauxiliary where (postid =" +
                                        um.Id + " OR comfirmid=" + um.Id + " OR recomfirmid=" + um.Id + " OR remarkid=" +
                                        um.Id + " OR summaryid=" + um.Id + ") AND currentUser<>" + um.Id +
                                        "  and projectid=" + projectid + " "
                                        +
                                        " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'质量问题表' as dtype,postername,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CONCAT('QualityQuestionForm_View.aspx?formId=',id) as url FROM problem_quality  where (postid =" +
                                        um.Id + " OR remarkid =" + um.Id + " OR summaryid=" + um.Id +
                                        ") AND currentUser<>" +
                                        um.Id + "  and projectid=" + projectid + " "
                                        +
                                        " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'安全问题表' as dtype,postername,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CONCAT('SecurityQuestionForm_View.aspx?formId=',id) as url FROM problem_sercurity where (postid =" +
                                        um.Id + " OR remarkid =" + um.Id + " OR summaryid=" + um.Id +
                                        ") AND currentUser<>" +
                                        um.Id + "  and projectid=" + projectid + " ";

                                    if (!string.IsNullOrEmpty(month))
                                    {
                                        sql =
                                            " SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth,projectname,'栋号班组用工成本表' as dtype,poster,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CONCAT('LaborCostForm_View.aspx?formId=',id) as url FROM cost_labor where (postid=" +
                                            um.Id + " OR comfirmid=" + um.Id + " OR recomfirmid=" + um.Id +
                                            " OR remarkid=" +
                                            um.Id + " OR summaryid=" + um.Id + ") AND currentUser <> " + um.Id +
                                            "  and projectid=" + projectid + " and posttime>'" + month + "-01' "
                                            +
                                            " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'管理成本表' as dtype,poster,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CONCAT('ManageCostForm_View.aspx?formId=',id) as url FROM cost_management where (postid =" +
                                            um.Id + " OR summaryid=" + um.Id + " OR remarkid=" + um.Id +
                                            ") AND currentUser<>" +
                                            um.Id + "  and projectid=" + projectid + " and posttime>'" + month + "-01' "
                                            +
                                            " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'栋号材料成本表' as dtype,poster,DATE_FORMAT(`posttime`,'%Y-%m-%d %H:%i:%s') AS posttime, CONCAT('MaterialCostForm_View.aspx?formId=',id) as url FROM cost_material where (postid =" +
                                            um.Id + " OR comfirmid=" + um.Id + " OR recomfirmid=" + um.Id +
                                            " OR remarkid=" +
                                            um.Id + " OR summaryid=" + um.Id + ") AND currentUser<>" + um.Id +
                                            "  and projectid=" + projectid + " and posttime>'" + month + "-01' "
                                            +
                                            " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'栋号工具辅材成本表' as dtype,poster,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CONCAT('MaterialAuxiliaryCostForm_View.aspx?formId=',id) as url FROM cost_materialauxiliary where (postid =" +
                                            um.Id + " OR comfirmid=" + um.Id + " OR recomfirmid=" + um.Id +
                                            " OR remarkid=" +
                                            um.Id + " OR summaryid=" + um.Id + ") AND currentUser<>" + um.Id +
                                            "  and projectid=" + projectid + " and posttime>'" + month + "-01' "
                                            +
                                            " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'质量问题表' as dtype,postername,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CONCAT('QualityQuestionForm_View.aspx?formId=',id) as url FROM problem_quality  where (postid =" +
                                            um.Id + " OR remarkid =" + um.Id + " OR summaryid=" + um.Id +
                                            ") AND currentUser<>" +
                                            um.Id + "  and projectid=" + projectid + " and posttime>'" + month + "-01' "
                                            +
                                            " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'安全问题表' as dtype,postername,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CONCAT('SecurityQuestionForm_View.aspx?formId=',id) as url FROM problem_sercurity where (postid =" +
                                            um.Id + " OR remarkid =" + um.Id + " OR summaryid=" + um.Id +
                                            ") AND currentUser<>" +
                                            um.Id + "  and projectid=" + projectid + " and posttime>'" + month + "-01' ";
                                    }
                                }
                                var result = new SxDal().GetData(sql);
                                json = WebHelper.GetObjJson(result);
                            }
                            else
                            {
                                var sql =
       " SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth,projectname,'栋号班组用工成本表' as dtype,poster,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CONCAT('LaborCostForm_View.aspx?formId=',id) as url FROM cost_labor where  summaryid is not null  "
       +
       " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'管理成本表' as dtype,poster,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CONCAT('ManageCostForm_View.aspx?formId=',id) as url FROM cost_management where  summaryid is not null "
       +
       " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'栋号材料成本表' as dtype,poster,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime, CONCAT('MaterialCostForm_View.aspx?formId=',id) as url FROM cost_material where  summaryid is not null   "
       +
       " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'栋号工具辅材成本表' as dtype,poster,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CONCAT('MaterialAuxiliaryCostForm_View.aspx?formId=',id) as url FROM cost_materialauxiliary where  summaryid is not null   "
       +
       " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'质量问题表' as dtype,postername,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CONCAT('QualityQuestionForm_View.aspx?formId=',id) as url FROM problem_quality  where  summaryid is not null   "
       +
       " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'安全问题表' as dtype,postername,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CONCAT('SecurityQuestionForm_View.aspx?formId=',id) as url FROM problem_sercurity where  summaryid is not null  ";

                                if (!string.IsNullOrEmpty(month))
                                {
                                    sql =
                                        " SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth,projectname,'栋号班组用工成本表' as dtype,poster,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CONCAT('LaborCostForm_View.aspx?formId=',id) as url FROM cost_labor where  summaryid is not null and posttime>'" + month + "-01' "
                                        +
                                        " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'管理成本表' as dtype,poster,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CONCAT('ManageCostForm_View.aspx?formId=',id) as url FROM cost_management where  summaryid is not null   and posttime>'" + month + "-01' "
                                        +
                                        " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'栋号材料成本表' as dtype,poster,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime, CONCAT('MaterialCostForm_View.aspx?formId=',id) as url FROM cost_material where  summaryid is not null  and posttime>'" + month + "-01' "
                                        +
                                        " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'栋号工具辅材成本表' as dtype,poster,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CONCAT('MaterialAuxiliaryCostForm_View.aspx?formId=',id) as url FROM cost_materialauxiliary where  summaryid is not null  and posttime>'" + month + "-01' "
                                        +
                                        " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'质量问题表' as dtype,postername,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CONCAT('QualityQuestionForm_View.aspx?formId=',id) as url FROM problem_quality  where  summaryid is not null   and posttime>'" + month + "-01' "
                                        +
                                        " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'安全问题表' as dtype,postername,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CONCAT('SecurityQuestionForm_View.aspx?formId=',id) as url FROM problem_sercurity where  summaryid is not null  and posttime>'" + month + "-01' ";
                                }
                                if (um.Group > 10) //直接取所有表单，总经理和财务
                                {
                                    sql =
                                        " SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth,projectname,'栋号班组用工成本表' as dtype,poster,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CONCAT('LaborCostForm_View.aspx?formId=',id) as url FROM cost_labor where (postid=" +
                                        um.Id + " OR comfirmid=" + um.Id + " OR recomfirmid=" + um.Id + " OR remarkid=" +
                                        um.Id + " OR summaryid=" + um.Id + ") AND currentUser <> " + um.Id  
                                        +
                                        " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'管理成本表' as dtype,poster,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CONCAT('ManageCostForm_View.aspx?formId=',id) as url FROM cost_management where (postid =" +
                                        um.Id + " OR summaryid=" + um.Id + " OR remarkid=" + um.Id +
                                        ") AND currentUser<>" +
                                        um.Id +  
                                        " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'栋号材料成本表' as dtype,poster,DATE_FORMAT(`posttime`,'%Y-%m-%d %H:%i:%s') AS posttime, CONCAT('MaterialCostForm_View.aspx?formId=',id) as url FROM cost_material where (postid =" +
                                        um.Id + " OR comfirmid=" + um.Id + " OR recomfirmid=" + um.Id + " OR remarkid=" +
                                        um.Id + " OR summaryid=" + um.Id + ") AND currentUser<>" + um.Id 
                                        +
                                        " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'栋号工具辅材成本表' as dtype,poster,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CONCAT('MaterialAuxiliaryCostForm_View.aspx?formId=',id) as url FROM cost_materialauxiliary where (postid =" +
                                        um.Id + " OR comfirmid=" + um.Id + " OR recomfirmid=" + um.Id + " OR remarkid=" +
                                        um.Id + " OR summaryid=" + um.Id + ") AND currentUser<>" + um.Id  
                                        +
                                        " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'质量问题表' as dtype,postername,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CONCAT('QualityQuestionForm_View.aspx?formId=',id) as url FROM problem_quality  where (postid =" +
                                        um.Id + " OR remarkid =" + um.Id + " OR summaryid=" + um.Id +
                                        ") AND currentUser<>" +um.Id  +
                                        " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'安全问题表' as dtype,postername,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CONCAT('SecurityQuestionForm_View.aspx?formId=',id) as url FROM problem_sercurity where (postid =" +
                                        um.Id + " OR remarkid =" + um.Id + " OR summaryid=" + um.Id +
                                        ") AND currentUser<>" +um.Id ;

                                    if (!string.IsNullOrEmpty(month))
                                    {
                                        sql =
                                            " SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth,projectname,'栋号班组用工成本表' as dtype,poster,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CONCAT('LaborCostForm_View.aspx?formId=',id) as url FROM cost_labor where (postid=" +
                                            um.Id + " OR comfirmid=" + um.Id + " OR recomfirmid=" + um.Id +
                                            " OR remarkid=" +
                                            um.Id + " OR summaryid=" + um.Id + ") AND currentUser <> " + um.Id +
                                            "  and posttime>'" + month + "-01' "
                                            +
                                            " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'管理成本表' as dtype,poster,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CONCAT('ManageCostForm_View.aspx?formId=',id) as url FROM cost_management where (postid =" +
                                            um.Id + " OR summaryid=" + um.Id + " OR remarkid=" + um.Id +
                                            ") AND currentUser<>" +
                                            um.Id + "   and posttime>'" + month + "-01' "
                                            +
                                            " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'栋号材料成本表' as dtype,poster,DATE_FORMAT(`posttime`,'%Y-%m-%d %H:%i:%s') AS posttime, CONCAT('MaterialCostForm_View.aspx?formId=',id) as url FROM cost_material where (postid =" +
                                            um.Id + " OR comfirmid=" + um.Id + " OR recomfirmid=" + um.Id +
                                            " OR remarkid=" +
                                            um.Id + " OR summaryid=" + um.Id + ") AND currentUser<>" + um.Id +
                                            "   and posttime>'" + month + "-01' "
                                            +
                                            " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'栋号工具辅材成本表' as dtype,poster,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CONCAT('MaterialAuxiliaryCostForm_View.aspx?formId=',id) as url FROM cost_materialauxiliary where (postid =" +
                                            um.Id + " OR comfirmid=" + um.Id + " OR recomfirmid=" + um.Id +
                                            " OR remarkid=" +
                                            um.Id + " OR summaryid=" + um.Id + ") AND currentUser<>" + um.Id +
                                            "   and posttime>'" + month + "-01' "
                                            +
                                            " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'质量问题表' as dtype,postername,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CONCAT('QualityQuestionForm_View.aspx?formId=',id) as url FROM problem_quality  where (postid =" +
                                            um.Id + " OR remarkid =" + um.Id + " OR summaryid=" + um.Id +
                                            ") AND currentUser<>" +
                                            um.Id + "   and posttime>'" + month + "-01' "
                                            +
                                            " UNION SELECT DATE_FORMAT(`posttime`, '%Y-%m') AS dmonth, projectname,'安全问题表' as dtype,postername,DATE_FORMAT(`posttime`, '%Y-%m-%d %H:%i:%s') AS posttime,CONCAT('SecurityQuestionForm_View.aspx?formId=',id) as url FROM problem_sercurity where (postid =" +
                                            um.Id + " OR remarkid =" + um.Id + " OR summaryid=" + um.Id +
                                            ") AND currentUser<>" +
                                            um.Id + "   and posttime>'" + month + "-01' ";
                                    }
                                }
                                var result = new SxDal().GetData(sql);
                                json = WebHelper.GetObjJson(result);
                            }
                        }
                        break;
                    }
                case "getdata":
                    {
                        var type = WebHelper.GetActionStr(context, "type");
                        var formid = WebHelper.GetActionStr(context, "formid");
                        var sql = "select * from " + type + " where id=" + formid;
                        var msg = new SxDal().GetData(sql);
                        json = WebHelper.GetObjJson(msg);
                        break;
                    }
                case "doUpdateWM":
                    {
                        var type = WebHelper.GetActionStr(context, "type");
                        var formid = WebHelper.GetActionStr(context, "formid");
                        var projectid = WebHelper.GetActionInt(context, "pid");
                        var worktimeDb = WebHelper.GetActionStr(context, "db");
                        var worktimeXb = WebHelper.GetActionStr(context, "xb");
                        var materialcost = WebHelper.GetActionStr(context, "mc");
                        if (um != null)
                        {
                            var step = SxDal.GetNextStep(projectid, -1, type, 2);
                            if (step != null)
                            {
                                var sql = "update " + type +
                                          " set worktimecost_db='" + worktimeDb +
                                          "',worktimecost_xb='" + worktimeXb +
                                          "',materialcost='" + materialcost +
                                          "',currentUser=" + step.CurrentUser +
                                          ",currentPage='" + step.CurrentPage +
                                          "',status='" + step.Status +
                                          "',state=" + step.State +
                                          " where id=" + formid;
                                var msg = new SxDal().AddData(sql);
                                json = WebHelper.GetObjJson(msg);
                            }
                        }
                        break;
                    }
                case "doRemark":
                    {
                        var type = WebHelper.GetActionStr(context, "type");
                        var formid = WebHelper.GetActionStr(context, "formid");
                        var remark = WebHelper.GetActionStr(context, "remark");
                        if (um != null)
                        {
                            var step = SxDal.GetNextStep(-1, -1, type, 1);
                            if (step != null)
                            {
                                var sql = "update " + type +
                                          " set remarkid=" + um.Id +
                                          ",remarkname='" + um.RealName +
                                          "',remark='" + remark +
                                          "',remarktime='" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") +
                                          "',currentUser=" + step.CurrentUser +
                                          ",currentPage='" + step.CurrentPage +
                                          "',status='" + step.Status +
                                          "',state=" + step.State +
                                          " where id=" + formid;
                                var msg = new SxDal().AddData(sql);
                                json = WebHelper.GetObjJson(msg);
                            }
                        }
                        break;
                    }
                case "doSummary":
                    {
                        var type = WebHelper.GetActionStr(context, "type");
                        var formid = WebHelper.GetActionStr(context, "formid");
                        var summary = WebHelper.GetActionStr(context, "summary");
                        if (um != null)
                        {
                            var step = SxDal.GetNextStep(-1, -1, type, 0);
                            if (step != null)
                            {
                                var sql = "update " + type + " set summaryid=" + um.Id + ",summaryname='" + um.RealName +
                                          "',summary='" + summary +
                                          "',summarytime='" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") +
                                          "',currentUser=" + step.CurrentUser +
                                          ",currentPage='" + step.CurrentPage +
                                          "',status='" + step.Status +
                                          "',state=" + step.State +
                                          " where id=" + formid;
                                if (type == "problem_sercurity" || type == "problem_quality")
                                {
                                    var levelno = WebHelper.GetActionStr(context, "levelno");
                                    sql = "update " + type + " set levelno='" + levelno +"',summaryid=" + um.Id + ",summaryname='" + um.RealName +
                                          "',summary='" + summary +
                                          "',summarytime='" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") +
                                          "',currentUser=" + step.CurrentUser +
                                          ",currentPage='" + step.CurrentPage +
                                          "',status='" + step.Status +
                                          "',state=" + step.State +
                                          " where id=" + formid;
                                }
                                var msg = new SxDal().AddData(sql);
                                json = WebHelper.GetObjJson(msg);
                            }
                        }
                        break;
                    }
                case "doComfirm":
                    {
                        var type = WebHelper.GetActionStr(context, "type"); //表名
                        var formid = WebHelper.GetActionStr(context, "formid"); //表单ID
                        var comfirmType = WebHelper.GetActionStr(context, "comfirmType"); //确认或二次而确认
                        var comfirmOption = WebHelper.GetActionStr(context, "cp"); //确认或退回
                        var remark = WebHelper.GetActionStr(context, "remark");
                        var ids = WebHelper.GetActionStr(context, "ids");
                        var projectid = -1;
                        var buildingid = -1;
                        if (!string.IsNullOrEmpty(ids) && ids.Contains("-"))
                        {
                            var arr = ids.Split('-');
                            projectid = Convert.ToInt32(arr[0]);
                            buildingid = Convert.ToInt32(arr[1]);
                        }
                        if (um != null)
                        {
                            var sql = "";
                            switch (comfirmType)
                            {
                                case "comfirm":
                                    if (comfirmOption == "1")
                                    {
                                        var step = SxDal.GetNextStep(projectid, buildingid, type, 3);
                                        if (step != null)
                                        {
                                            sql = "update " + type + " set comfirmid=" + um.Id +
                                                  ",comfirmname='" + um.RealName +
                                                  "',comfirmtime='" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") +
                                                  "',comfirmremark='" + remark +
                                                  "',currentUser=" + step.CurrentUser +
                                                  ",currentPage='" + step.CurrentPage +
                                                  "',status='" + step.Status +
                                                  "',state=" + step.State +
                                                  " where id=" + formid;
                                        }
                                    }
                                    if (comfirmOption == "0")
                                    {
                                        var step = SxDal.GetNextStep(projectid, buildingid, type, 5);
                                        if (step != null)
                                        {
                                            sql = "update " + type + " set comfirmid=" + um.Id +
                                                  ",comfirmname='" + um.RealName +
                                                  "',comfirmtime='" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") +
                                                  "',comfirmremark='" + remark +
                                                  "',currentUser=postid" +
                                                  ",currentPage='" + step.CurrentPage +
                                                  "',status='" + step.Status +
                                                  "',state=" + step.State +
                                                  " where id=" + formid;
                                        }
                                    }
                                    break;
                                case "recomfirm":
                                    if (comfirmOption == "1")
                                    {
                                        var step = SxDal.GetNextStep(projectid, -1, type, 2);
                                        if (step != null)
                                        {
                                            sql = "update " + type + " set recomfirmid=" + um.Id +
                                                  ",recomfirmname='" + um.RealName +
                                                  "',recomfirmtime='" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") +
                                                  "',recomfirmremark='" + remark +
                                                  "',currentUser=" + step.CurrentUser +
                                                  ",currentPage='" + step.CurrentPage +
                                                  "',status='" + step.Status +
                                                  "',state=" + step.State +
                                                  " where id=" + formid;
                                        }
                                    }
                                    if (comfirmOption == "0")
                                    {
                                        var step = SxDal.GetNextStep(projectid, -1, type, 5);
                                        if (step != null)
                                        {
                                            sql = "update " + type + " set recomfirmid=" + um.Id +
                                                  ",recomfirmname='" + um.RealName +
                                                  "',recomfirmtime='" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") +
                                                  "',recomfirmremark='" + remark +
                                                  "',currentUser=postid" +
                                                  ",currentPage='" + step.CurrentPage +
                                                  "',status='" + step.Status +
                                                  "',state=" + step.State +
                                                  " where id=" + formid;
                                        }
                                    }
                                    break;
                            }
                            var msg = new SxDal().AddData(sql);
                            json = WebHelper.GetObjJson(msg);

                        }
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
                            var manage = WebHelper.GetActionStr(context, "manage"); //bArr
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

                            var list = (from string item in context.Request.Params
                                        where item.StartsWith("bArr")
                                        select context.Request.Params[item]
                                into v
                                        select v.Split(',')).ToList();
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
                            sql += list.Aggregate("",
                                (current, item) =>
                                    current +
                                    ("insert into projectinfo (projectid,projectname,buildingid,buildingleaderid,buildingleader,state)values(" +
                                     projectid + ",'" + projectname + "'," + item[0] + "," + item[1] + ",'" + item[2] +
                                     "',1);"));
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
                            var manage = WebHelper.GetActionStr(context, "manage"); //bArr
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

                            var list = (from string item in context.Request.Params
                                        where item.StartsWith("bArr")
                                        select context.Request.Params[item]
                                into v
                                        select v.Split(',')).ToList();
                            var sql =
                                "insert into projects(projectname,projectleaderid,projectleader,productleaderid,productleader,accountantid,accountant,constructionleaderid,constructionleader,safetyleaderid,safetyleader,qualityleaderid,qualityleader,storekeeperid,storekeeper,buildingTotal,state)values('" +
                                projectname + "'," + marr[0] + ",'" + marr[1] + "'," + parr[0] + ",'" + parr[1] + "'," +
                                aarr[0] + ",'" + aarr[1] + "'," + carr[0] + ",'" + carr[1] + "'," + saarr[0] + ",'" +
                                saarr[1] + "'," + qarr[0] + ",'" + qarr[1] + "'," + starr[0] + ",'" + starr[1] + "'," +
                                list.Count + ",1);select @@identity;";
                            var id = new SxDal().GetId(sql);
                            if (id > 0)
                            {
                                sql = list.Aggregate("",
                                    (current, item) =>
                                        current +
                                        ("insert into projectinfo (projectid,projectname,buildingid,buildingleaderid,buildingleader,state)values(" +
                                         id + ",'" + projectname + "'," + item[0] + "," + item[1] + ",'" + item[2] + "',1);"));
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
                        var teamleader = WebHelper.GetActionStr(context, "teamleader"); //fffff
                        var worker = WebHelper.GetActionStr(context, "worker");
                        var responsibleperson1 = WebHelper.GetActionStr(context, "responsibleperson1");
                        var responsibleperson2 = WebHelper.GetActionStr(context, "responsibleperson2");
                        var rebuildsolution = WebHelper.GetActionStr(context, "rebuildsolution");
                        var rebuilder = WebHelper.GetActionStr(context, "rebuilder");
                        var worktimecostDb = WebHelper.GetActionStr(context, "worktimecost_db");
                        var worktimecostXb = WebHelper.GetActionStr(context, "worktimecost_xb");
                        var materialcost = WebHelper.GetActionStr(context, "materialcost");
                        HttpPostedFile file = context.Request.Files["pic"];
                        var attachment = UploadFile(context,file);
                     
                        if (!string.IsNullOrEmpty(teamleader) && teamleader.Contains("-"))
                        {
                            var arr = teamleader.Split('-');
                            teamleaderid = Convert.ToInt32(arr[0]);
                            teamleader = arr[1];
                        }
                        if (um != null)
                        {
                            var nextStep = SxDal.GetNextStep(projectid, -1, "problem_sercurity", 3, teamleaderid);
                            if (nextStep != null)
                            {
                                var sql =
                                    "INSERT INTO problem_sercurity(levelno,projectid,projectname,buildingno,location,checkdate," +
                                    "finishdate,problemdescription,causation,teamleaderid,teamleader,worker,responsibleperson1," +
                                    "responsibleperson2,rebuildsolution,rebuilder,worktimecost_db,worktimecost_xb," +
                                    "materialcost,postid,postername,posttime,currentUser,currentPage,status,state,attachment)values('"
                                    + levelno + "',"
                                    + projectid + ",'"
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
                                    + worktimecostDb + "','"
                                    + worktimecostXb + "','"
                                    + materialcost + "','"
                                    + um.Id + "','"
                                    + um.RealName + "','"
                                    + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "',"
                                    + nextStep.CurrentUser + ",'"
                                    + nextStep.CurrentPage + "','"
                                    + nextStep.Status + "',"
                                    + nextStep.State + ",'"+ attachment + "'); ";
                                var msg = new SxDal().AddData(sql);
                                json = WebHelper.GetObjJson(msg);
                            }
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
                        var teamleader = WebHelper.GetActionStr(context, "teamleader"); //fffff
                        var worker = WebHelper.GetActionStr(context, "worker");
                        var responsibleperson1 = WebHelper.GetActionStr(context, "responsibleperson1");
                        var responsibleperson2 = WebHelper.GetActionStr(context, "responsibleperson2");
                        var rebuildsolution = WebHelper.GetActionStr(context, "rebuildsolution");
                        var rebuilder = WebHelper.GetActionStr(context, "rebuilder");
                        var worktimecostDb = WebHelper.GetActionStr(context, "worktimecost_db");
                        var worktimecostXb = WebHelper.GetActionStr(context, "worktimecost_xb");
                        var materialcost = WebHelper.GetActionStr(context, "materialcost");
                        HttpPostedFile file = context.Request.Files["pic"];
                        var attachment = UploadFile(context, file);
                        if (!string.IsNullOrEmpty(teamleader) && teamleader.Contains("-"))
                        {
                            var arr = teamleader.Split('-');
                            teamleaderid = Convert.ToInt32(arr[0]);
                            teamleader = arr[1];
                        }
                        if (um != null)
                        {
                            var dal = new SxDal();
                            var nextStep = SxDal.GetNextStep(projectid, -1, "problem_quality", 3, teamleaderid);
                            if (nextStep != null)
                            {
                                var sql =
                                    "INSERT INTO problem_quality(levelno,projectid,projectname,buildingno,location,checkdate," +
                                    "finishdate,problemdescription,causation,teamleaderid,teamleader,worker,responsibleperson1," +
                                    "responsibleperson2,rebuildsolution,rebuilder,worktimecost_db,worktimecost_xb," +
                                    "materialcost,postid,postername,posttime,currentUser,currentPage,status,state,attachment)values('"
                                    + levelno + "',"
                                    + projectid + ",'"
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
                                    + worktimecostDb + "','"
                                    + worktimecostXb + "','"
                                    + materialcost + "','"
                                    + um.Id + "','"
                                    + um.RealName + "','"
                                    + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "',"
                                    + nextStep.CurrentUser + ",'"
                                    + nextStep.CurrentPage + "','"
                                    + nextStep.Status + "',"
                                    + nextStep.State + ",'" + attachment + "'); ";
                                var msg = dal.AddData(sql);
                                json = WebHelper.GetObjJson(msg);
                            }
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
                        var teamleader = WebHelper.GetActionStr(context, "teamleader"); //fffff
                        var workcontent = WebHelper.GetActionStr(context, "workcontent");
                        var unit = WebHelper.GetActionStr(context, "unit");
                        var price = WebHelper.GetActionStr(context, "price");
                        var number = WebHelper.GetActionStr(context, "number");
                        var totalprice = WebHelper.GetActionStr(context, "totalprice");
                        var remarkbywork = WebHelper.GetActionStr(context, "remarkbywork");
                        HttpPostedFile file = context.Request.Files["pic"];
                        var attachment = UploadFile(context, file);
                        if (!string.IsNullOrEmpty(teamleader) && teamleader.Contains("-"))
                        {
                            var arr = teamleader.Split('-');
                            teamleaderid = Convert.ToInt32(arr[0]);
                            teamleader = arr[1];
                        }
                        if (um != null)
                        {
                            var nextStep = SxDal.GetNextStep(projectid, -1, "cost_labor", 4);
                            if (nextStep != null)
                            {
                                var sql =
                                    "INSERT INTO cost_labor(projectid,projectname,buildingno,startdate,endate,worktype,teamleaderid,teamleader,workcontent,unit,price,worktime,totalprice,remarkbywork,postid,poster,posttime,currentUser,currentPage,status,state,attachment) VALUES(" +
                                    projectid + ",'" + projectname + "','" + buildingno + "','" + startdate + "','" +
                                    endate + "','" + worktype + "'," + teamleaderid + ",'" + teamleader + "','" +
                                    workcontent + "','" + unit + "'," + price + "," + number +
                                    "," + totalprice + ",'" + remarkbywork + "'," + um.Id + ",'" + um.RealName + "','" +
                                    DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "'," + teamleaderid + ",'"
                                    + nextStep.CurrentPage + "','"
                                    + nextStep.Status + "',"
                                    + nextStep.State + ",'" + attachment + "'); ";
                                var msg = new SxDal().AddData(sql);
                                json = WebHelper.GetObjJson(msg);
                            }
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
                        HttpPostedFile file = context.Request.Files["pic"];
                        var attachment = UploadFile(context, file);
                        if (um != null)
                        {
                            var nextStep = SxDal.GetNextStep(projectid, -1, "cost_management", 2);
                            if (nextStep != null)
                            {
                                var sql =
                                    "INSERT INTO cost_management(projectid,projectname,curdate,type,content,unit,price,number,totalprice,remarkbyaccount,postid,poster,posttime,currentUser,currentPage,status,state,attachment) VALUES(" +
                                    projectid + ",'" + projectname + "','" + curdate + "','" + type + "','" + content +
                                    "','" + unit + "'," + price + "," + number +
                                    "," + totalprice + ",'" + remarkbyaccount + "'," + um.Id + ",'" + um.RealName +
                                    "','" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "',"
                                    + nextStep.CurrentUser + ",'"
                                    + nextStep.CurrentPage + "','"
                                    + nextStep.Status + "',"
                                    + nextStep.State + ",'" + attachment + "'); ";
                                var msg = new SxDal().AddData(sql);
                                json = WebHelper.GetObjJson(msg);
                            }
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
                        HttpPostedFile file = context.Request.Files["pic"];
                        var attachment = UploadFile(context, file);
                        if (!string.IsNullOrEmpty(teamleader) && teamleader.Contains("-"))
                        {
                            var arr = teamleader.Split('-');
                            teamleaderid = Convert.ToInt32(arr[0]);
                            teamleader = arr[1];
                        }
                        if (um != null)
                        {
                            var nextStep = SxDal.GetNextStep(projectid, -1, "cost_material", 4);
                            if (nextStep != null)
                            {
                                var sql =
                                    "INSERT INTO cost_material(projectid,projectname,buildingno,curdate,teamleaderid,teamleader,materialname,unit,price,number,totalprice,remarkbyworker,postid,poster,posttime,currentUser,currentPage,status,state,attachment) VALUES(" +
                                    projectid + ",'" + projectname + "','" + buildingno + "','" + curdate + "'," +
                                    teamleaderid + ",'" + teamleader + "','" + materialname + "','" + unit + "'," +
                                    price + "," + number + "," + totalprice +
                                    ",'" + remarkbyworker + "'," + um.Id + ",'" + um.RealName + "','" +
                                    DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "'," + teamleaderid + ",'"
                                    + nextStep.CurrentPage + "','"
                                    + nextStep.Status + "',"
                                    + nextStep.State + ",'" + attachment + "'); ";
                                var msg = new SxDal().AddData(sql);
                                json = WebHelper.GetObjJson(msg);
                            }

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
                        HttpPostedFile file = context.Request.Files["pic"];
                        var attachment = UploadFile(context, file);
                        if (!string.IsNullOrEmpty(teamleader) && teamleader.Contains("-"))
                        {
                            var arr = teamleader.Split('-');
                            teamleaderid = Convert.ToInt32(arr[0]);
                            teamleader = arr[1];
                        }
                        if (um != null)
                        {
                            var nextStep = SxDal.GetNextStep(projectid, -1, "cost_materialauxiliary", 4);
                            if (nextStep != null)
                            {
                                var sql =
                                    "INSERT INTO cost_materialauxiliary(projectid,projectname,buildingno,curdate,teamleaderid,teamleader,materialname,unit,price,number,totalprice,remarkbyworker,postid,poster,posttime,currentUser,currentPage,status,state,attachment) VALUES(" +
                                    projectid + ",'" + projectname + "','" + buildingno + "','" + curdate + "'," +
                                    teamleaderid + ",'" + teamleader + "','" + materialname + "','" + unit + "'," +
                                    price + "," + number + "," + totalprice +
                                    ",'" + remarkbyworker + "'," + um.Id + ",'" + um.RealName + "','" +
                                    DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "'," + teamleaderid + ",'"
                                    + nextStep.CurrentPage + "','"
                                    + nextStep.Status + "',"
                                    + nextStep.State + ",'"+ attachment + "'); ";
                                var msg = new SxDal().AddData(sql);
                                json = WebHelper.GetObjJson(msg);
                            }
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
                                ? "SELECT CONCAT(levelno,'级') as levelno,CONCAT(projectname,'|',buildingno,'栋|',location) as addr,DATE_FORMAT(`checkdate`, '%Y-%m-%d') AS checkdate,DATE_FORMAT(`finishdate`, '%Y-%m-%d') AS finishdate,problemdescription,causation,teamleader,worker,concat(responsibleperson1,'/',responsibleperson1) as manager,rebuildsolution,rebuilder,CONCAT(worktimecost_db,'大班;',worktimecost_xb,'小班') as worktimecost,materialcost FROM	problem_sercurity a where   a.projectid=" +
                                  projectid
                                : "SELECT CONCAT(levelno,'级') as levelno,CONCAT(projectname,'|',buildingno,'栋|',location) as addr,DATE_FORMAT(`checkdate`, '%Y-%m-%d') AS checkdate,DATE_FORMAT(`finishdate`, '%Y-%m-%d') AS finishdate,problemdescription,causation,teamleader,worker,concat(responsibleperson1,'/',responsibleperson1) as manager,rebuildsolution,rebuilder,CONCAT(worktimecost_db,'大班;',worktimecost_xb,'小班') as worktimecost,materialcost FROM	problem_sercurity A WHERE   A.projectid=" +
                                  projectid + " and a.checkdate>='" + month + "-01" + "'  and a.checkdate<'" +
                                  (Convert.ToDateTime(month + "-01").AddMonths(1).ToString("yyyy-MM-dd")) + "'";
                            var result = new SxDal().GetData(sql);
                            json = WebHelper.GetObjJson(result);
                        }
                        else
                        {
                            var sql = string.IsNullOrEmpty(month)
                               ? "SELECT CONCAT(levelno,'级') as levelno,CONCAT(projectname,'|',buildingno,'栋|',location) as addr,DATE_FORMAT(`checkdate`, '%Y-%m-%d') AS checkdate,DATE_FORMAT(`finishdate`, '%Y-%m-%d') AS finishdate,problemdescription,causation,teamleader,worker,concat(responsibleperson1,'/',responsibleperson1) as manager,rebuildsolution,rebuilder,CONCAT(worktimecost_db,'大班;',worktimecost_xb,'小班') as worktimecost,materialcost FROM	problem_sercurity a "
                               : "SELECT CONCAT(levelno,'级') as levelno,CONCAT(projectname,'|',buildingno,'栋|',location) as addr,DATE_FORMAT(`checkdate`, '%Y-%m-%d') AS checkdate,DATE_FORMAT(`finishdate`, '%Y-%m-%d') AS finishdate,problemdescription,causation,teamleader,worker,concat(responsibleperson1,'/',responsibleperson1) as manager,rebuildsolution,rebuilder,CONCAT(worktimecost_db,'大班;',worktimecost_xb,'小班') as worktimecost,materialcost FROM	problem_sercurity A WHERE   " +
                                 " a.checkdate>='" + month + "-01" + "'  and a.checkdate<'" +
                                 (Convert.ToDateTime(month + "-01").AddMonths(1).ToString("yyyy-MM-dd")) + "'";
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
                                ? "SELECT CONCAT(levelno,'级') as levelno,CONCAT(projectname,'|',buildingno,'栋|',location) as addr,DATE_FORMAT(`checkdate`, '%Y-%m-%d') AS checkdate,DATE_FORMAT(`finishdate`, '%Y-%m-%d') AS finishdate,problemdescription,causation,teamleader,worker,concat(responsibleperson1,'/',responsibleperson1) as manager,rebuildsolution,rebuilder,CONCAT(worktimecost_db,'大班;',worktimecost_xb,'小班') as worktimecost,materialcost FROM	problem_quality a where  a.projectid=" +
                                  projectid
                                : "SELECT CONCAT(levelno,'级') as levelno,CONCAT(projectname,'|',buildingno,'栋|',location) as addr,DATE_FORMAT(`checkdate`, '%Y-%m-%d') AS checkdate,DATE_FORMAT(`finishdate`, '%Y-%m-%d') AS finishdate,problemdescription,causation,teamleader,worker,concat(responsibleperson1,'/',responsibleperson1) as manager,rebuildsolution,rebuilder,CONCAT(worktimecost_db,'大班;',worktimecost_xb,'小班') as worktimecost,materialcost FROM	problem_quality A WHERE  A.projectid=" +
                                  projectid + " and a.checkdate>='" + month + "-01" + "'  and a.checkdate<'" +
                                  (Convert.ToDateTime(month + "-01").AddMonths(1).ToString("yyyy-MM-dd")) + "'";
                            var result = new SxDal().GetData(sql);
                            json = WebHelper.GetObjJson(result);
                        }
                        else
                        {
                            var sql = string.IsNullOrEmpty(month)
                                ? "SELECT CONCAT(levelno,'级') as levelno,CONCAT(projectname,'|',buildingno,'栋|',location) as addr,DATE_FORMAT(`checkdate`, '%Y-%m-%d') AS checkdate,DATE_FORMAT(`finishdate`, '%Y-%m-%d') AS finishdate,problemdescription,causation,teamleader,worker,concat(responsibleperson1,'/',responsibleperson1) as manager,rebuildsolution,rebuilder,CONCAT(worktimecost_db,'大班;',worktimecost_xb,'小班') as worktimecost,materialcost FROM	problem_quality a "
                                : "SELECT CONCAT(levelno,'级') as levelno,CONCAT(projectname,'|',buildingno,'栋|',location) as addr,DATE_FORMAT(`checkdate`, '%Y-%m-%d') AS checkdate,DATE_FORMAT(`finishdate`, '%Y-%m-%d') AS finishdate,problemdescription,causation,teamleader, worker,concat(responsibleperson1,'/',responsibleperson1) as manager,rebuildsolution,rebuilder,CONCAT(worktimecost_db,'大班;',worktimecost_xb,'小班') as worktimecost,materialcost FROM	problem_quality A WHERE  " +
                                  "a.checkdate>='" + month + "-01" + "'  and a.checkdate<'" +
                                  (Convert.ToDateTime(month + "-01").AddMonths(1).ToString("yyyy-MM-dd")) + "'";
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
                                ? "SELECT	concat(projectname,'|',buildingno,'栋') as addr,DATE_FORMAT(`startdate`, '%Y-%m-%d') AS startdate,DATE_FORMAT(`endate`, '%Y-%m-%d') AS endate,concat(worktype,'/',teamleader) as worker,workcontent,unit,price,worktime,totalprice,remarkbywork FROM cost_labor a where  a.projectid=" +
                                  projectid
                                : "SELECT	concat(projectname,'|',buildingno,'栋') as addr,DATE_FORMAT(`startdate`, '%Y-%m-%d') AS startdate,DATE_FORMAT(`endate`, '%Y-%m-%d') AS endate,concat(worktype,'/',teamleader) as worker,workcontent,unit,price,worktime,totalprice,remarkbywork FROM cost_labor A WHERE A.projectid=" +
                                  projectid + " and a.startdate>='" + month + "-01" + "'  and a.startdate<'" +
                                  (Convert.ToDateTime(month + "-01").AddMonths(1).ToString("yyyy-MM-dd")) + "'";
                            var result = new SxDal().GetData(sql);
                            json = WebHelper.GetObjJson(result);
                        }
                        else
                        {
                            var sql = string.IsNullOrEmpty(month)
                               ? "SELECT	concat(projectname,'|',buildingno,'栋') as addr,DATE_FORMAT(`startdate`, '%Y-%m-%d') AS startdate,DATE_FORMAT(`endate`, '%Y-%m-%d') AS endate,concat(worktype,'/',teamleader) as worker,workcontent,unit,price,worktime,totalprice,remarkbywork FROM cost_labor a "
                               : "SELECT	concat(projectname,'|',buildingno,'栋') as addr,DATE_FORMAT(`startdate`, '%Y-%m-%d') AS startdate,DATE_FORMAT(`endate`, '%Y-%m-%d') AS endate,concat(worktype,'/',teamleader) as worker,workcontent,unit,price,worktime,totalprice,remarkbywork FROM cost_labor A WHERE " +
                                 " a.startdate>='" + month + "-01" + "'  and a.startdate<'" +
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
                                ? "SELECT concat(projectname,'|',buildingno,'栋') as addr,DATE_FORMAT(`curdate`, '%Y-%m-%d') AS curdate,teamleader,materialname,unit,number,price,totalprice,remarkbyworker  FROM cost_material a where a.projectid=" +
                                  projectid
                                : "SELECT concat(projectname,'|',buildingno,'栋') as addr,DATE_FORMAT(`curdate`, '%Y-%m-%d') AS curdate,teamleader,materialname,unit,number,price,totalprice,remarkbyworker FROM cost_material A WHERE A.projectid=" +
                                  projectid + " and a.curdate>='" + month + "-01" + "'  and a.curdate<'" +
                                  (Convert.ToDateTime(month + "-01").AddMonths(1).ToString("yyyy-MM-dd")) + "'";
                            var result = new SxDal().GetData(sql);
                            json = WebHelper.GetObjJson(result);
                        }
                        else
                        {
                            var sql = string.IsNullOrEmpty(month)
                               ? "SELECT concat(projectname,'|',buildingno,'栋') as addr,DATE_FORMAT(`curdate`, '%Y-%m-%d') AS curdate,teamleader,materialname,unit,number,price,totalprice,remarkbyworker  FROM cost_material a "
                               : "SELECT concat(projectname,'|',buildingno,'栋') as addr,DATE_FORMAT(`curdate`, '%Y-%m-%d') AS curdate,teamleader,materialname,unit,number,price,totalprice,remarkbyworker FROM cost_material A WHERE     a.curdate>='" + month + "-01" + "'  and a.curdate<'" +
                                 (Convert.ToDateTime(month + "-01").AddMonths(1).ToString("yyyy-MM-dd")) + "'";
                            var result = new SxDal().GetData(sql);
                            json = WebHelper.GetObjJson(result);
                        }
                        break;
                    }
                case "GetMaterialAuxiliaryCost":
                    {
                        var projectid = WebHelper.GetActionInt(context, "ProjectId");
                        var month = WebHelper.GetActionStr(context, "month");
                        if (projectid > 0)
                        {
                            var sql = string.IsNullOrEmpty(month)
                                ? "SELECT concat(projectname,'|',buildingno,'栋') as addr,DATE_FORMAT(`curdate`, '%Y-%m-%d') AS curdate,teamleader,materialname,unit,number,price,totalprice,remarkbyworker FROM	cost_materialauxiliary a where a.projectid=" +
                                  projectid
                                : "SELECT concat(projectname,'|',buildingno,'栋') as addr,DATE_FORMAT(`curdate`, '%Y-%m-%d') AS curdate,teamleader,materialname,unit,number,price,totalprice,remarkbyworker FROM	cost_materialauxiliary A WHERE A.projectid=" +
                                  projectid + " and a.curdate>='" + month + "-01" + "'  and a.curdate<'" +
                                  (Convert.ToDateTime(month + "-01").AddMonths(1).ToString("yyyy-MM-dd")) + "'";
                            var result = new SxDal().GetData(sql);
                            json = WebHelper.GetObjJson(result);
                        }
                        else
                        {
                            var sql = string.IsNullOrEmpty(month)
                                ? "SELECT concat(projectname,'|',buildingno,'栋') as addr,DATE_FORMAT(`curdate`, '%Y-%m-%d') AS curdate,teamleader,materialname,unit,number,price,totalprice,remarkbyworker FROM	cost_materialauxiliary a "
                                : "SELECT concat(projectname,'|',buildingno,'栋') as addr,DATE_FORMAT(`curdate`, '%Y-%m-%d') AS curdate,teamleader,materialname,unit,number,price,totalprice,remarkbyworker FROM	cost_materialauxiliary A WHERE  a.curdate>='" + month + "-01" + "'  and a.curdate<'" +
                                  (Convert.ToDateTime(month + "-01").AddMonths(1).ToString("yyyy-MM-dd")) + "'";
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
                                ? "SELECT	projectname,DATE_FORMAT(`curdate`, '%Y-%m-%d') AS curdate,type,content,unit,number,price,totalprice,remarkbyaccount FROM	cost_management a where a.projectid=" +
                                  projectid
                                : "SELECT	projectname,DATE_FORMAT(`curdate`, '%Y-%m-%d') AS curdate,type,content,unit,number,price,totalprice,remarkbyaccount FROM	cost_management A WHERE  A.projectid=" +
                                  projectid + " and a.curdate>='" + month + "-01" + "'  and a.curdate<'" +
                                  (Convert.ToDateTime(month + "-01").AddMonths(1).ToString("yyyy-MM-dd")) + "'";
                            var result = new SxDal().GetData(sql);
                            json = WebHelper.GetObjJson(result);
                        }
                        else
                        {
                            var sql = string.IsNullOrEmpty(month)
                                ? "SELECT	projectname,DATE_FORMAT(`curdate`, '%Y-%m-%d') AS curdate,type,content,unit,number,price,totalprice,remarkbyaccount FROM	cost_management a "
                                : "SELECT	projectname,DATE_FORMAT(`curdate`, '%Y-%m-%d') AS curdate,type,content,unit,number,price,totalprice,remarkbyaccount FROM	cost_management A WHERE    a.curdate>='" + month + "-01" + "'  and a.curdate<'" +
                                  (Convert.ToDateTime(month + "-01").AddMonths(1).ToString("yyyy-MM-dd")) + "'";
                            var result = new SxDal().GetData(sql);
                            json = WebHelper.GetObjJson(result);
                        }
                        break;
                    }
            }
            context.Response.Write(json);
        }

        private string UploadFile(HttpContext context,HttpPostedFile file)
        {
            var attachment = "";
            if (file != null && !string.IsNullOrEmpty(file.FileName))
            {
                try
                {
                    var index = file.FileName.LastIndexOf(".", StringComparison.Ordinal);
                    string filename = DateTime.Now.Ticks + file.FileName.Substring(index, file.FileName.Length - index);
                    string path = context.Server.MapPath("~/uploads/" + filename);
                    attachment = filename;
                    file.SaveAs(path);
                }
                catch (Exception e)
                {
                    return "";
                }
            }
            return attachment;
        }

        public bool IsReusable
        {
            get { return false; }
        }
    }
}