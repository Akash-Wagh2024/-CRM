using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Security.Policy;
using System.IO;

namespace goGst
{
    public partial class User_Product : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString());

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["ClientID"] != null)
                {
                    SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ConnectionString);
                    connection.Open();

                    string query = "SELECT clientname, company_name, contact2, contact1, email, website, image FROM client WHERE client_id = @clientID";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        int clientID = Convert.ToInt32(Session["ClientID"]);
                        command.Parameters.AddWithValue("@clientID", clientID);

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                Txtname.Text = reader["clientname"].ToString();
                                Label1.Text = reader["clientname"].ToString();
                                Txtcompanyenterprisesname.Text = reader["company_name"].ToString();
                                Txtcontact2.Text = reader["contact2"].ToString();
                                Txtcontact1.Text = reader["contact1"].ToString();
                                Txtemail.Text = reader["email"].ToString();
                                Txtwebsite.Text = reader["website"].ToString();

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
                    connection.Close();
                }
            }
        }


        protected void update1_Click(object sender, EventArgs e)
        {
            if (Session["ClientID"] != null)
            {


                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ConnectionString))
                {
                    connection.Open();

                    byte[] image = null;
                    using (Stream fs = fuUpload1.PostedFile.InputStream)
                    {
                        using (BinaryReader br = new BinaryReader(fs))
                        {
                            image = br.ReadBytes((int)fs.Length);
                        }
                    }

                    string updateQuery = "UPDATE client SET contact1 = @contact1, image=@image  WHERE client_id = @clientID";

                    using (SqlCommand updateCommand = new SqlCommand(updateQuery, connection))
                    {
                        updateCommand.Parameters.AddWithValue("@clientID", Session["ClientID"]);
                        updateCommand.Parameters.AddWithValue("@contact1", Txtcontact1.Text);
                        updateCommand.Parameters.AddWithValue("@image", image);


                        int i = updateCommand.ExecuteNonQuery();

                        if (i > 0)
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "SuccessScript", "alert('Update successful...'); setTimeout(function(){ window.location.href = 'Client-profile.aspx'; });", true);
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "ErrorScript", "alert('Update failed...');", true);
                        }
                    }

                }
            }
        }
    }
}










