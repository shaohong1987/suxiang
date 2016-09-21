using System;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.SessionState;
using suxiang.mobile.Dal;
using suxiang.mobile.Helper;
using suxiang.Model;

namespace suxiang.mobile.Handler
{
    /// <summary>
    ///     auth 的摘要说明
    /// </summary>
    public class Auth : IHttpHandler, IRequiresSessionState
    {
        public void ProcessRequest(HttpContext context)
        {
            var json = "";
            var action = WebHelper.GetActionStr(context, "action");
            switch (action)
            {
                case "loginaction":
                {
                    var usercode = WebHelper.GetActionStr(context, "usercode");
                    var userpass = WebHelper.GetActionStr(context, "userpass");
                    var user = new UsersModel {EmployeeNo = usercode, Password = userpass};
                    var msg = new SxDal().Login(user);
                    json = WebHelper.GetObjJson(msg);
                    if (msg.Data != null)
                        context.Session["user"] = msg.Data;
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