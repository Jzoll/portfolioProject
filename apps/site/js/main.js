document.getElementById("year").textContent = new Date().getFullYear();

function printResume() {
  window.print();
}

document.getElementById("print-btn").addEventListener("click", printResume);
document.querySelectorAll(".print-trigger").forEach((btn) => {
  btn.addEventListener("click", printResume);
});

const resumeModal = document.getElementById("resume-modal");

document.querySelectorAll(".view-resume-trigger").forEach((btn) => {
  btn.addEventListener("click", () => resumeModal.showModal());
});

document.getElementById("resume-modal-close").addEventListener("click", () => {
  resumeModal.close();
});

// Close when clicking the backdrop (outside the dialog content)
resumeModal.addEventListener("click", (e) => {
  if (e.target === resumeModal) resumeModal.close();
});
