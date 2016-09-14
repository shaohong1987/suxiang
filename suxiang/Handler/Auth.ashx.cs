using System.Web;
using System.Web.SessionState;
using suxiang.Dal;
using suxiang.Model;

namespace suxiang.Handler
{
    /// <summary>
    ///     Auth 的摘要说明
    /// </summary>
    public class Auth : IHttpHandler, IRequiresSessionState
    {
        public void ProcessRequest(HttpContext context)
        {
            var json = "";
            var action = WebHelper.GetActionStr(context, "action");
            switch (action)
            {
                case "Login":
                    {
                        var usercode = WebHelper.GetActionStr(context, "usercode");
                        var userpass = WebHelper.GetActionStr(context, "userpass");
                        var user = new UsersModel { EmployeeNo = usercode, Password = userpass };
                        var msg = new SxDal().Login(user);
                        json = WebHelper.GetObjJson(msg);
                        if (msg.Data != null)
                            context.Session["user"] = msg.Data;
                        break;
                    }
                case "UpdatePwd":
                    {
                        break;
                    }
                case "AddNewUser":
                    {
                        break;
                    }
                case "DelUser":
                    {
                        break;
                    }
                case "GetUserByUserName":
                    {
                        var userName = WebHelper.GetActionStr(context, "UserName");
                        var sql = string.IsNullOrEmpty(userName)
                                 ? "SELECT * FROM Users"
                                 : "SELECT * FROM Users A WHERE A.RealName LIKE '%" + userName + "%'";
	                    var result = new SxDal().GetData(sql);
	                    json = WebHelper.GetObjJson(result);
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