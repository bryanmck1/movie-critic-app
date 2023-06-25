// Hamburger icon in Navbar
document.addEventListener("turbo:load", function () {
  const hamburgerMenu = document.querySelector(".hamburger-menu");
  const navbarMenu = document.querySelector(".navbar-menu");

  hamburgerMenu.addEventListener("click", function () {
    navbarMenu.classList.toggle("hidden");
  });
});

// Profile expansion pop up box in Navbar
document.addEventListener("turbo:load", function () {
  const profileMenu = document.querySelector("#account-menu");
  const profile = document.querySelector(".profile");

  profileMenu.addEventListener("click", function () {
    profile.classList.toggle("hidden");
  });
});

// Toggles content on review movie page
document.addEventListener("turbo:load", function () {
  const toggleBtn = document.querySelector("#toggle-btn");
  const movieDetails = document.querySelector("#movie-details");

  toggleBtn.addEventListener("click", function () {
    movieDetails.classList.toggle("hidden");
    toggleBtn.classList.toggle("rotate-180");
  });
});

// Shows delete modal on index page
document.addEventListener("turbo:load", function () {
  const deleteBtns = document.querySelectorAll(".review-delete");

  deleteBtns.forEach(function (deleteBtn) {
    deleteBtn.addEventListener("click", function () {
      const reviewId = deleteBtn.dataset.reviewId;
      const modal = document.querySelector(`#modal-${reviewId}`);
      modal.classList.toggle("hidden");
    });
  });
});

// Shows modal to filter by release_year
// document.addEventListener("turbo:load", function () {
//   const releaseBtn = document.querySelector("#release_modal");
//   const releaseModal = document.querySelector("#release_years");

//   releaseBtn.addEventListener("click", function () {
//     releaseModal.classList.toggle("hidden");
//   });
// });
