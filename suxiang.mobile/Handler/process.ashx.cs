using System.Web;
using System.Web.SessionState;
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
                um = (UsersModel) context.Session["user"];
            else
                context.Response.Redirect("~/login.htm");
            var json = "";
            var action = WebHelper.GetActionStr(context, "action");
            switch (action)
            {
                case "aa":
                    break;
            }
            context.Response.Write(json);
        }

        public bool IsReusable
        {
            get { return false; }
        }
    }
}