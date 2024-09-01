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
    public partial class Admin_Product_Update : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["crm_con"].ToString());
        //string productId = "";
        protected void Page_Load(object sender, EventArgs e)
        {           
            if (!IsPostBack)
            {              
                if (Request.QueryString["product_id"] != null)
                {
                    getProductInfo();
                    string productId = Request.QueryString["product_id"];
                    //txtName.Text = productId;
                }
            }
        }

        private void getProductInfo()
        {
            string productId = Request.QueryString["product_id"];
            string query = "SELECT product_name, product_code, image1, image2, image3, image4, description FROM product WHERE product_id = @product_id";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                cmd.Parameters.AddWithValue("@product_id", productId);
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        txtName.Text = reader["product_name"].ToString();
                        txtCode.Text = reader["product_code"].ToString();
                        txtDescription.Text = reader["description"].ToString();
                        if (!reader.IsDBNull(reader.GetOrdinal("image1")))
                        {
                            byte[] imageData = (byte[])reader["image1"];
                            string base64String = Convert.ToBase64String(imageData);
                            selectedAvatar1.ImageUrl = "data:image/jpeg;base64," + base64String;
                        }
                        if (!reader.IsDBNull(reader.GetOrdinal("image2")))
                        {
                            byte[] imageData = (byte[])reader["image2"];
                            string base64String = Convert.ToBase64String(imageData);
                            selectedAvatar2.ImageUrl = "data:image/jpeg;base64," + base64String;
                        }
                        if (!reader.IsDBNull(reader.GetOrdinal("image3")))
                        {
                            byte[] imageData = (byte[])reader["image3"];
                            string base64String = Convert.ToBase64String(imageData);
                            selectedAvatar3.ImageUrl = "data:image/jpeg;base64," + base64String;
                        }
                        if (!reader.IsDBNull(reader.GetOrdinal("image4")))
                        {
                            byte[] imageData = (byte[])reader["image4"];
                            string base64String = Convert.ToBase64String(imageData);
                            selectedAvatar4.ImageUrl = "data:image/jpeg;base64," + base64String;
                        }
                    }
                }
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
        }
        // Update Product
        protected void btnsubmit_Click(object sender, EventArgs e)
        {
            try
            {
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                // Retrieve image bytes based on whether file upload controls have files
                byte[] selectedAvatar1 = GetFileBytes(fuUpload1);
                byte[] selectedAvatar2 = GetFileBytes(fuUpload2);
                byte[] selectedAvatar3 = GetFileBytes(fuUpload3);
                byte[] selectedAvatar4 = GetFileBytes(fuUpload4);

                // Compress image bytes
                selectedAvatar1 = CompressImage(selectedAvatar1);
                selectedAvatar2 = CompressImage(selectedAvatar2);
                selectedAvatar3 = CompressImage(selectedAvatar3);
                selectedAvatar4 = CompressImage(selectedAvatar4);

                string productName = txtName.Text;
                string productCode = txtCode.Text;
                string description = txtDescription.Text;
                string username = Session["username"]?.ToString();
                string productId = Request.QueryString["product_id"];
                long adminId = Convert.ToInt64(Session["admin_id"]);

                using (SqlCommand cmd = new SqlCommand("ManageProduct", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@operation", "Update");
                    cmd.Parameters.AddWithValue("@product_name", productName);
                    cmd.Parameters.AddWithValue("@product_code", productCode);
                    cmd.Parameters.Add("@image1", SqlDbType.VarBinary, -1).Value = selectedAvatar1 != null ? (object)selectedAvatar1 : DBNull.Value; // Handle null image bytes
                    cmd.Parameters.Add("@image2", SqlDbType.VarBinary, -1).Value = selectedAvatar2 != null ? (object)selectedAvatar2 : DBNull.Value; // Handle null image bytes
                    cmd.Parameters.Add("@image3", SqlDbType.VarBinary, -1).Value = selectedAvatar3 != null ? (object)selectedAvatar3 : DBNull.Value; // Handle null image bytes
                    cmd.Parameters.Add("@image4", SqlDbType.VarBinary, -1).Value = selectedAvatar4 != null ? (object)selectedAvatar4 : DBNull.Value; // Handle null image bytes
                    cmd.Parameters.AddWithValue("@description", description);
                    cmd.Parameters.AddWithValue("@admin_id", adminId);
                    cmd.Parameters.AddWithValue("@updated_by", username);
                    cmd.Parameters.AddWithValue("@product_id", productId);

                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "SuccessScript", "alert('Product Updated Successfully...'); setTimeout(function(){ window.location.href = 'Manage-Product.aspx'; });", true);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "ErrorScript", "alert('Failed to update product. Please try again later.');", true);
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "ErrorScript", $"alert('Error: {ex.Message}');", true);
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
        }



        // Code for compressing image
        private byte[] CompressImage(byte[] imageBytes)
        {
            if (imageBytes == null)
            {
                return null;
            }

            using (MemoryStream ms = new MemoryStream(imageBytes))
            {
                using (System.Drawing.Image image = System.Drawing.Image.FromStream(ms))
                {
                    // Compress the image
                    ImageCodecInfo jpegCodec = GetEncoderInfo(ImageFormat.Jpeg);
                    EncoderParameters encoderParams = new EncoderParameters(1);
                    encoderParams.Param[0] = new EncoderParameter(Encoder.Quality, 50L); // Adjust the quality as needed

                    using (MemoryStream compressedStream = new MemoryStream())
                    {
                        image.Save(compressedStream, jpegCodec, encoderParams);
                        return compressedStream.ToArray();
                    }
                }
            }
        }

        // Helper method to get JPEG codec
        private static ImageCodecInfo GetEncoderInfo(ImageFormat format)
        {
            ImageCodecInfo[] codecs = ImageCodecInfo.GetImageDecoders();
            foreach (ImageCodecInfo codec in codecs)
            {
                if (codec.FormatID == format.Guid)
                {
                    return codec;
                }
            }
            return ImageCodecInfo.GetImageDecoders().FirstOrDefault(codec => codec.FormatID == format.Guid);
        }

        // Method to get file bytes from FileUpload control
        private byte[] GetFileBytes(FileUpload fileUpload)
        {
            if (fileUpload.HasFile)
            {
                using (Stream fs = fileUpload.PostedFile.InputStream)
                {
                    using (BinaryReader br = new BinaryReader(fs))
                    {
                        return br.ReadBytes((int)fs.Length);
                    }
                }
            }
            return null;
        }

    }
}