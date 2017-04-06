using System;
using System.Security.Cryptography;
using System.Text;
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
                case "adduser":
                    {
                        var username = WebHelper.GetActionStr(context, "username");
                        var realname = WebHelper.GetActionStr(context, "realname");
                        var password = WebHelper.GetActionStr(context, "password");
                        var email = WebHelper.GetActionStr(context, "email");
                        var group = WebHelper.GetActionInt(context, "group");
                        var state = WebHelper.GetActionInt(context, "state");
                        var model = new UsersModel
                        {
                            EmployeeNo = username,
                            Password = Md5(password),
                            RealName = realname,
                            Email = email,
                            Group = group,
                            State = state > 0
                        };
                        var t = new SxDal().CheckUserName(username);
                        if (!t.State)
                        {
                            var result = new SxDal().AddNewUser(model);
                            json = WebHelper.GetObjJson(result);
                        }
                        else
                        {
                            var msg = new MsgModel
                            {
                                State = false,
                                Msg = "该员工账号已经存在!",
                                Data = null
                            };
                            json = WebHelper.GetObjJson(msg);
                        }
                        
                        break;
                    }
                case "updateuser":
                    {
                        var username = WebHelper.GetActionStr(context, "username");
                        var realname = WebHelper.GetActionStr(context, "realname");
                        var password = WebHelper.GetActionStr(context, "password");
                        var email = WebHelper.GetActionStr(context, "email");
                        var group = WebHelper.GetActionInt(context, "group");
                        var state = WebHelper.GetActionInt(context, "state");
                        var model = new UsersModel
                        {
                            EmployeeNo = username,
                            Password = string.IsNullOrEmpty(password) ? "" : Md5(password),
                            RealName = realname,
                            Email = email,
                            Group = group,
                            State = state > 0
                        };
                        var result = new SxDal().UpdateUserInfo(model);
                        json = WebHelper.GetObjJson(result);
                        break;
                    }
                case "deluser":
                {
                    var un = WebHelper.GetActionStr(context, "uname");
                    var result=new SxDal().DelUser(un);
                    json = WebHelper.GetObjJson(result);
                    break;
                }
                case "checkusername":
                    {
                        var userName = WebHelper.GetActionStr(context, "uname");
                        var result = new SxDal().CheckUserName(userName);
                        json = WebHelper.GetObjJson(result);
                        break;
                    }
                case "GetUserByUserName":
                    {
                        var userName = WebHelper.GetActionStr(context, "UserName");
                        var sql = string.IsNullOrEmpty(userName)
                                 ? "SELECT * FROM Users"
                                 : "SELECT * FROM Users A WHERE A.realName LIKE '%" + userName + "%'";
                        var result = new SxDal().GetUsers(sql);
                        json = WebHelper.GetObjJson(result);
                        break;
                    }
                case "GetUserWithOutAdmin":
	            {
                    var sql = "select * from users where `group`<>1;";
                    var result = new SxDal().GetUsers(sql);
                    json = WebHelper.GetObjJson(result);
                    break;
	            }
                case "updatepwd":
                    {
                        UsersModel um = null;
                        if (context.Session["user"] != null)
                            um = (UsersModel)context.Session["user"];
                        else
                            context.Response.Redirect("~/Login.aspx");
                        var oldPassword = WebHelper.GetActionStr(context, "oldpassword");
                        var newPassword = WebHelper.GetActionStr(context, "newpassword");
                        if (um != null)
                        {
                            var sql = "update users set password='" + Md5(newPassword) + "' where username='" + um.EmployeeNo + "' and password='" + Md5(oldPassword) + "';";
                            var result = new SxDal().UpdatePwd(sql);
                            json = WebHelper.GetObjJson(result);
                        }
                        break;
                    }
                case "getuser":
                    {
                        UsersModel um = null;
                        if (context.Session["user"] != null)
                            um = (UsersModel)context.Session["user"];
                        else
                            context.Response.Redirect("~/Login.aspx");
                        if (um != null)
                        {
                            json = WebHelper.GetObjJson(um);
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

        private static string Md5(string str)
        {
            byte[] result = Encoding.Default.GetBytes(str);
            MD5 md5 = new MD5CryptoServiceProvider();
            byte[] output = md5.ComputeHash(result);
            return BitConverter.ToString(output).Replace("-", "");
        }
    }
}