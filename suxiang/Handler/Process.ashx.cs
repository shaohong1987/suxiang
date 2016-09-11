using System.Web;

namespace suxiang.Handler
{
    /// <summary>
    ///     Process 的摘要说明
    /// </summary>
    public class Process : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            var json = "";
            var action = WebHelper.GetActionStr(context, "action");
            switch (action)
            {
                case "SecurityQuestionForm":
                {

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