const fragment = new DocumentFragment();
const url = "http://localhost:4567/tests";

fetch(url)
    .then(response => response.json())
    .then(data => {
        const tableBody = document.getElementById("tests-table-body");
        data.forEach(test => {
            const row = document.createElement("tr");
            row.innerHTML = `
          <td>${test.result_token}</td>
          <td>${test.result_date}</td>
          <td>${test.cpf}</td>
          <td>${test.name}</td>
          <td>${test.doctor.name}</td>
          <td>${test.doctor.crm}</td>
        `;
            fragment.appendChild(row);
        });
        tableBody.appendChild(fragment);
    })