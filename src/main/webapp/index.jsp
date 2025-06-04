<%-- 
    Document   : index
    Created on : May 22, 2025, 4:37:26 PM
    Author     : Laptop K1
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <section class="vh-100" style="background: linear-gradient(135deg, #add8e6, #87ceeb); ">
        <div class="container py-5 h-100">
          <div class="row d-flex justify-content-center align-items-center h-100">
            <div class="col col-xl-10">
              <div class="card" style="border-radius: 1rem;">
                <div class="row g-0">
                    <div class="col-md-6 col-lg-5 d-none d-md-block" style="background-image: url(Pic/logoDN.png); background-size: cover">
                  </div>
                  <div class="col-md-6 col-lg-7 d-flex align-items-center">
                    <div class="card-body p-4 p-lg-5 text-black">
      
                        <form action="Extend/login.jsp" method="post">
      
                        <div class="d-flex align-items-center mb-3 pb-1">


                          <i class="fas fa-cubes fa-2x me-3" style="color: #ff6219;"></i>
                          <span class="h1 fw-bold mb-0">Đăng nhập</span>
                        </div>
                        <div class="form-outline mb-4">
                          <input style="border: 1px solid black;" type="text" id="form2Example17" name="username" class="form-control form-control-lg" required/>
                          <label class="form-label" for="form2Example17">Tải khoản</label>
                        </div>
      
                        <div class="form-outline mb-4">
                          <input style="border: 1px solid black;" type="password" name="password" id="form2Example27" class="form-control form-control-lg" required/>
                          <label class="form-label" for="form2Example27">Mật khẩu</label>
                        </div>
      
                        <div class="pt-1 mb-4">
                          <input class="btn btn-dark btn-lg btn-block" type="submit" value="Login"></input>
                        </div>
      
                        <a class="small text-muted" href="#!">Quên mật khẩu?</a>


                      </form>
      
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
</body>
</html>
