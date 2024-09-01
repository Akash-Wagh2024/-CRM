using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using System.Xml.Linq;
using System.Drawing;
using System.Drawing.Imaging;

namespace goGst
{
    public partial class Marketing_Profile : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString());    
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["MarketingID"] != null)
                {
                    int marketing_id = Convert.ToInt32(Session["MarketingID"]);
                    con.Open();
                    string query = "SELECT name, email, contact1,marketing_id,gender,image FROM marketing WHERE marketing_id = @marketing_id";
                    using (SqlCommand command = new SqlCommand(query, con))
                    {
                        command.Parameters.AddWithValue("@marketing_id", marketing_id);
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                validationServer01.Text = reader["name"].ToString();
                                validationServer02.Text = reader["email"].ToString();
                                validationServer03.Text = reader["contact1"].ToString();
                                validationServer05.Text = reader["gender"].ToString();
                                validationServer04.Text = reader["marketing_id"].ToString();
                                if (!reader.IsDBNull(reader.GetOrdinal("image")))
                                {
                                    byte[] imageData = (byte[])reader["image"];
                                    string base64String = Convert.ToBase64String(imageData);
                                    selectedAvatar.ImageUrl = "data:image/jpeg;base64," + base64String;
                                }
                                else
                                {
                                    selectedAvatar.ImageUrl = "https://mdbootstrap.com/img/Photos/Others/placeholder-avatar.jpg";
                                }
                            }
                        }
                    }
                    con.Close();
                }

            }
        }
        


        protected void update1_Click(object sender, EventArgs e)
        {
            if (Session["MarketingID"] != null)
            {
                int MarketingID = Convert.ToInt32(Session["MarketingID"]);
                con.Open();

                byte[] image = null;
                using (Stream fs = fuUpload1.PostedFile.InputStream)
                {
                    using (BinaryReader br = new BinaryReader(fs))
                    {
                        image = br.ReadBytes((int)fs.Length);
                    }
                }
                string query = "update marketing set image=@image WHERE marketing_id = @marketing_id";
                using (SqlCommand command = new SqlCommand(query, con))
                {
                    command.Parameters.AddWithValue("@marketing_id", MarketingID);
                    command.Parameters.AddWithValue("@image", image);

                    int i = command.ExecuteNonQuery();
                    if (i > 0)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "SuccessScript", "alert('Profile Photo Updated...'); setTimeout(function(){ window.location.href = 'Marketing-profile.aspx'; });", true);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "ErrorScript", "alert('Update failed...');", true);
                    }
                }
                con.Close();
            }
        }
    }
}