FROM ubuntu:latest

RUN apt-get update && apt-get install -y git python3 python3-pip gunicorn wget
RUN wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.focal_amd64.deb && apt install -y ./wkhtmltox_0.12.6-1.focal_amd64.deb
RUN git clone https://github.com/kit-sdq/disclaimer-programming-lecture-generation.git
RUN cd disclaimer-programming-lecture-generation && pip3 install flask pdfkit qrcode Pillow
RUN cd disclaimer-programming-lecture-generation/disclaimer/templates && sed -i "s:{{ url_for('static', filename=':/disclaimer/static/:g" index.html
RUN cd disclaimer-programming-lecture-generation/disclaimer/templates && sed -i "s:') }}::g" index.html

EXPOSE 5000/tcp

ENTRYPOINT cd disclaimer-programming-lecture-generation/disclaimer && gunicorn wsgi:app --bind 0.0.0.0:5000 --error-logfile test.log
