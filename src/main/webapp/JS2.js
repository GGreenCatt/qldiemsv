//===============Bật tắt Dropdown==================
document.addEventListener('DOMContentLoaded', function() {
    const dropdownTogglers = document.querySelectorAll('.dropdown-toggler');

    dropdownTogglers.forEach(function(toggler) {
      toggler.addEventListener('click', function() {
        dropdownTogglers.forEach(function(otherToggler) {
          if (otherToggler !== toggler) {
            otherToggler.classList.remove('open');
          }
        });

        toggler.classList.toggle('open');
      });
    });

    // ===========Modal Nhập Excel===============
    // Lấy các phần tử modal
    var modal = document.getElementById("excelImportModal");
    var btn = document.getElementById("openExcelModalButton");
    var span = document.getElementsByClassName("close-button")[0];

    // Khi người dùng nhấp vào nút, mở modal
    if (btn) { // Đảm bảo nút tồn tại trước khi thêm sự kiện
        btn.onclick = function() {
            modal.style.display = "block";
        }
    }

    // Khi người dùng nhấp vào <span> (x), đóng modal
    if (span) { // Đảm bảo nút đóng tồn tại
        span.onclick = function() {
            modal.style.display = "none";
        }
    }

    // Khi người dùng nhấp vào bất cứ đâu bên ngoài modal, đóng nó
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
});
//================Tìm kiếm table=================
function myFunction() {
  // Declare variables
  var input, filter, table, tr, td, i, txtValue;
  input = document.getElementById("myInput");
  filter = input.value.toUpperCase();
  table = document.getElementById("myTable");
  tr = table.getElementsByTagName("tr");

  // Loop through all table rows, and hide those who don't match the search query
  for (i = 0; i < tr.length; i++) {
    td = tr[i].getElementsByTagName("td")[2];
    if (td) {
      txtValue = td.textContent || td.innerText;
      if (txtValue.toUpperCase().indexOf(filter) > -1) {
        tr[i].style.display = "";
      } else {
        tr[i].style.display = "none";
      }
    }
  }
}
//==============Hiệu ứng Banner===================
let slideIndex = 0;
// Bọc hàm showSlides trong một hàm để chỉ gọi khi DOM đã tải đủ hoặc khi cần
function initializeSlideshow() {
    let i;
    let slides = document.getElementsByClassName("mySlides");
    let dots = document.getElementsByClassName("dot");
    // Kiểm tra xem có slides nào không trước khi chạy vòng lặp
    if (slides.length === 0) return;

    for (i = 0; i < slides.length; i++) {
      slides[i].style.display = "none";
    }
    slideIndex++;
    if (slideIndex > slides.length) {slideIndex = 1}
    for (i = 0; i < dots.length; i++) {
      dots[i].className = dots[i].className.replace(" dotactive", "");
    }
    slides[slideIndex-1].style.display = "block";
    dots[slideIndex-1].className += " dotactive";
    setTimeout(initializeSlideshow, 3000); // Gọi lại chính nó để lặp
}

// Có vẻ như hàm showSlides được gọi toàn cục, nên tôi sẽ giữ nguyên cách gọi này
// nhưng với cơ chế kiểm tra bên trong hàm
showSlides(); // Giữ nguyên dòng này nếu nó được gọi toàn cục

function showSlides() {
    let i;
    let slides = document.getElementsByClassName("mySlides");
    let dots = document.getElementsByClassName("dot");
    if (slides.length === 0) { // Nếu không có slides, dừng hàm
        return;
    }

    for (i = 0; i < slides.length; i++) {
        slides[i].style.display = "none";
    }
    slideIndex++;
    if (slideIndex > slides.length) {
        slideIndex = 1
    }
    for (i = 0; i < dots.length; i++) {
        dots[i].className = dots[i].className.replace(" dotactive", "");
    }
    slides[slideIndex - 1].style.display = "block";
    dots[slideIndex - 1].className += " dotactive";
    setTimeout(showSlides, 3000); // Change image every 3 seconds
}

//===========Phản hồi===============
function showAdditionalSelect() {
    var roleSelect = document.getElementById("roleSelect");
    var additionalSelect = document.getElementById("additionalSelect");

    if (roleSelect.value === "GV") {
      additionalSelect.style.display = "block";
    } else {
      additionalSelect.style.display = "none";
    }
}