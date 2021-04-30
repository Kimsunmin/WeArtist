<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/topMenuHead.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<!--  -->
<body>
<head>

</head>

<body>
  
  <!-- ======= Header ======= -->
  <!-- ======= Hero Section ======= -->
  <section id="hero" class="middle">
    <div class="hero-container" data-aos="zoom-in" data-aos-delay="100">
      <h1 class="mb-4 pb-0">Welcome to <br><span>We Artist</span>!</h1>
      <p class="mb-4 pb-0">Manage your portfolio easily and FREE</p>
      <a href="/user/join" class="glightbox play-btn mb-4"></a>
      <a href="/user/login" onclick="window.open(this.href, '_blank', 'width=500, height=400, left=550, top=200'); return false;" class="about-btn scrollto"> Already signed up? <i class="far fa-grin-hearts"></i></a>
    </div>
  </section>
  <!-- End Hero Section -->

  
  
  <!-- footer section -->
  <%@include file ="/WEB-INF/views/include/footer.jsp" %>
  <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

  <!-- Vendor JS Files -->
  <script src="assets/vendor/aos/aos.js"></script>
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="assets/vendor/glightbox/js/glightbox.min.js"></script>

  <!-- Template Main JS File -->
  <script src="assets/js/main.js"></script>
  
  <!-- Gallery JS File -->
  <script src="${context}/resources/js/gallery/three.js"></script>
  <script src="${context}/resources/js/gallery/GLTFLoader.js"></script>
  <script type='module' src="${context}/resources/js/gallery/indexBack.js"></script>
</body>

</body>
</html>