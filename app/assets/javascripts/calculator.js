$(document).ready(() => {
    $('#calculator-btn').click(() => {
        $('#calculator-modal').modal('toggle');
    }); 

    $('#calculator-form').submit(e => {
        e.preventDefault();
        let formData = {};
        $('#calculator-form').serializeArray().forEach(field => {
            formData[field.name] = field.value
        });
        let url = `/products/${formData.length}/${formData.width}`
        url+= `/${formData.height}`;
        url+= `/${formData.weight}.json `;

        $.ajax({
            url: url,
            type: 'GET'
        }).done(data => {
            $('#search-results').text(`Your Result: ${data.name}`);
            setTimeout(() => {
                $('#jumbotron-search-results').text(`Your Result: ${data.name}`);
                $('#calculator-modal').modal('toggle');
                $('#calculator-form')[0].reset();
            }, 5000);
            console.log(data);
        }).fail((jqXHR, textStatus, errorThrown) => {
            $('#search-results').text('Sorry there was no results.');
        });
    });
});
