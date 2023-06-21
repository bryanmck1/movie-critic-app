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

// Shows modal to delete a review
document.addEventListener("turbo:load", function () {
  const deleteBtn = document.querySelector("#review-delete");
  const deleteModal = document.querySelector("#delete-modal");

  deleteBtn.addEventListener("click", function () {
    deleteModal.classList.toggle("hidden");
  });
});

// Removes modal when user cancels a review deletion
document.addEventListener("turbo:load", function () {
  const cancelBtn = document.querySelector("#cancel-modal");
  const deleteModal = document.querySelector("#delete-modal");

  cancelBtn.addEventListener("click", function () {
    deleteModal.classList.toggle("hidden");
  });
});
