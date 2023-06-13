// Hamburger icon in Navbar

document.addEventListener("DOMContentLoaded", function () {
  const hamburgerMenu = document.querySelector(".hamburger-menu");
  const navbarMenu = document.querySelector(".navbar-menu");

  hamburgerMenu.addEventListener("click", function () {
    navbarMenu.classList.toggle("hidden");
  });
});

// Profile expansion pop up box in Navbar
document.addEventListener("DOMContentLoaded", function () {
  const profileMenu = document.querySelector(".account-menu");
  const profile = document.querySelector(".profile");

  profileMenu.addEventListener("click", function () {
    profile.classList.toggle("hidden");
  });
});
