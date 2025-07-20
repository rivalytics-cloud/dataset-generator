document.addEventListener("DOMContentLoaded", () => {
  const form = document.getElementById("datasetForm");
  if (!form) return;

  form.addEventListener("submit", async (e) => {
    e.preventDefault();
    window.location.href = "generating.html";

    const payload = {
      industry: form.industry.value,
      department: form.department.value,
      details: form.details.value,
      rowCount: parseInt(form.rowCount.value),
      format: form.format.value,
      email: form.email.value || null
    };

    try {
      const res = await fetch("https://your-api.com/generate", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(payload)
      });

      if (!res.ok) {
        window.location.href = "error.html";
        return;
      }

      const data = await res.json();
      sessionStorage.setItem("datasetInfo", JSON.stringify(data));
      window.location.href = "success.html";

    } catch (err) {
      console.error("Error generating dataset:", err);
      window.location.href = "error.html";
    }
  });
});