using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace goGst
{
    public partial class CRM_Login : System.Web.UI.Page
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString());
        protected void Page_Load(object sender, EventArgs e)
        {

        }



        protected void Button1_Click1(object sender, EventArgs e)
        {
            try
            {
                bool rememberMe = CBRememberme.Checked;
                string username = txtUsername.Text;
                string password = txtPassword.Text;
                conn.Open();
                SqlDataAdapter cd = new SqlDataAdapter("select * from client where client_username='" + username + "' and client_password='" + password + "' AND is_delete=0", conn);
                SqlDataAdapter sd = new SqlDataAdapter("select * from support where support_username='" + username + "' and support_password='" + password + "'AND is_active=0", conn);
                SqlDataAdapter ad = new SqlDataAdapter("select * from Admin_login where admin_username='" + username + "' and admin_password='" + password + "'", conn);
                SqlDataAdapter md = new SqlDataAdapter("select * from marketing where marketing_username='" + username + "' and marketing_password='" + password + "'AND is_active=0", conn);
                DataTable cc = new DataTable("cd");
                DataTable ss = new DataTable("sd");
                DataTable aa = new DataTable("ad");
                DataTable mm = new DataTable("md");
                cd.Fill(cc);
                sd.Fill(ss);
                ad.Fill(aa);
                md.Fill(mm);

                if (cc.Rows.Count == 1)
                {
                    Session["username"] = cc.Rows[0]["client_username"].ToString();
                    if (rememberMe)
                    {
                        // If "Remember Me" checkbox is checked, set a persistent cookie
                        HttpCookie cookie = new HttpCookie("LoginCookie");
                        cookie.Values["username"] = username;
                        cookie.Values["password"] = password;
                        cookie.Expires = DateTime.Now.AddYears(1); // Set the cookie expiration to one year
                        Response.Cookies.Add(cookie);
                    }
                    Session["username"] = cc.Rows[0]["client_username"].ToString();
                    Session["password"] = cc.Rows[0]["client_password"].ToString();
                    
                    SqlCommand clientIdCommand = new SqlCommand("SELECT client_id FROM client WHERE client_username = @username AND client_password = @password AND is_delete=0", conn);
                    clientIdCommand.Parameters.AddWithValue("@username", username);
                    clientIdCommand.Parameters.AddWithValue("@password", password);

                    object clientIdResult = clientIdCommand.ExecuteScalar();

                    if (clientIdResult != null)
                    {
                        string clientId = clientIdResult.ToString();
                        Session["ClientID"] = clientId;

                        ScriptManager.RegisterStartupScript(this, GetType(), "SuccessScript", "alert('Client Login successfull...'); setTimeout(function(){ window.location.href = 'Client-NewProduct.aspx'; });", true);

                    }
                }
                else if (ss.Rows.Count == 1)
                {
                    Session["username"] = ss.Rows[0]["support_username"].ToString();
                    Session["password"] = ss.Rows[0]["support_password"].ToString();
                    if (rememberMe)
                    {
                        // If "Remember Me" checkbox is checked, set a persistent cookie
                        HttpCookie cookie = new HttpCookie("LoginCookie");
                        cookie.Values["username"] = username;
                        cookie.Values["password"] = password;
                        cookie.Expires = DateTime.Now.AddYears(1); // Set the cookie expiration to one year
                        Response.Cookies.Add(cookie);
                    }
                    SqlCommand supportIdCommand = new SqlCommand("SELECT support_id FROM support WHERE support_username = @username AND support_password = @password AND is_active=0", conn);
                    supportIdCommand.Parameters.AddWithValue("@username", username);
                    supportIdCommand.Parameters.AddWithValue("@password", password);

                    object supportIdResult = supportIdCommand.ExecuteScalar();

                    if (supportIdResult != null)
                    {
                        string supportId = supportIdResult.ToString();
                        Session["SupportID"] = supportId;

                        ScriptManager.RegisterStartupScript(this, GetType(), "SuccessScript", "alert('Support Person Login successfull...'); setTimeout(function(){ window.location.href = 'Support-Dashboard.aspx'; });", true);
                    }

                }
                else if (aa.Rows.Count == 1)
                {

                    Session["username"] = aa.Rows[0]["admin_username"].ToString();
                    Session["password"] = aa.Rows[0]["admin_password"].ToString();
                    if (rememberMe)
                    {
                        // If "Remember Me" checkbox is checked, set a persistent cookie
                        HttpCookie cookie = new HttpCookie("LoginCookie");
                        cookie.Values["username"] = username;
                        cookie.Values["password"] = password;
                        cookie.Expires = DateTime.Now.AddYears(1); // Set the cookie expiration to one year
                        Response.Cookies.Add(cookie);
                    }
                    SqlCommand adminIdCommand = new SqlCommand("SELECT admin_id FROM Admin_login WHERE admin_username = @username AND admin_password = @password", conn);
                    adminIdCommand.Parameters.AddWithValue("@username", username);
                    adminIdCommand.Parameters.AddWithValue("@password", password);
                    object adminIdResult = adminIdCommand.ExecuteScalar();
                    if (adminIdResult != null)
                    {
                        string adminId = adminIdResult.ToString();
                        Session["AdminID"] = adminId;
                        ScriptManager.RegisterStartupScript(this, GetType(), "SuccessScript", "alert('Admin Login successfull...'); setTimeout(function(){ window.location.href = 'Lead-Dashboard.aspx'; });", true);
                    }
                }
                else if (mm.Rows.Count == 1)
                {
                    Session["username"] = mm.Rows[0]["marketing_username"].ToString();
                    Session["password"] = mm.Rows[0]["marketing_password"].ToString();
                    if (rememberMe)
                    {
                        // If "Remember Me" checkbox is checked, set a persistent cookie
                        HttpCookie cookie = new HttpCookie("LoginCookie");
                        cookie.Values["username"] = username;
                        cookie.Values["password"] = password;
                        cookie.Expires = DateTime.Now.AddYears(1); // Set the cookie expiration to one year
                        Response.Cookies.Add(cookie);
                    }
                    SqlCommand marketingIdCommand = new SqlCommand("SELECT marketing_id FROM marketing WHERE marketing_username = @username AND marketing_password = @password AND is_active=0", conn);
                    marketingIdCommand.Parameters.AddWithValue("@username", username);
                    marketingIdCommand.Parameters.AddWithValue("@password", password);

                    object marketingIdResult = marketingIdCommand.ExecuteScalar();

                    if (marketingIdResult != null)
                    {
                        string marketingId = marketingIdResult.ToString();
                        Session["MarketingID"] = marketingId;

                        ScriptManager.RegisterStartupScript(this, GetType(), "SuccessScript", "alert('Marketing Person Login successful...'); setTimeout(function(){ window.location.href = 'Marketing-Dashboard.aspx'; });", true);
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "successScript", "alert('Login Failed...');", true);

                }
            }
            catch (Exception ex)
            {
                
                ScriptManager.RegisterStartupScript(this, this.GetType(), "errorScript", $"alert('An error occurred: {ex.Message}');", true);
            }
            finally
            {
                conn.Close();
            }
        }
    }
}