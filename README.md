# Charger App

## Splash Screen
<img width="351" alt="SplashScreen" src="https://user-images.githubusercontent.com/24764184/179423868-e3c14ce3-fbb6-4123-acce-b6d6f3195dc2.png">

## Login Page 
Uygulama açıldıktan sonra Giriş ekranı gelmektedir.

<img width="450" alt="LoginPage" src="https://user-images.githubusercontent.com/24764184/179424003-0c1b235a-53fe-4c22-acd1-89cc0da15a8f.png">

Kullanıcı mail adresi girdikten sonra 'Giriş Yap' butonuna tıklayarak uygulamaya giriş yapmaktadır.

Burada HTTP POST Request kullanılmaktadır. Requestte beklenen Body 'email' ve 'deviceID' uygun bir şekilde parametre olarak verilmektedir.

Login işleminde MVVC design pattern kullanılmıştır.

Kullanıcı profil ekranının sol üstünde bulunan butona tıklayınca Profil sayfasına yönlendirilmektedir.

## Profil Page 

<img width="450" alt="ProfilePage" src="https://user-images.githubusercontent.com/24764184/179424217-ece3e112-c9d4-48bb-afe2-5ba0c0c6fb0b.png">

Kullanıcının giriş yaptığı E-mail ve cihaz ID'si burada gösterilmektedir. Kullanıcı 'ÇIKIŞ YAP' butonuna tıklayarak uygulamadan Logout olmaktadır. Logout için POST request kullanılmaktadır.

Randevu oluştur butonuna tıklayınca Şehir seçin ekranı açılmaktadır.

## City Page 

<img width="450" alt="CityPage" src="https://user-images.githubusercontent.com/24764184/179424305-51039078-0e9c-4966-9d75-a2c09582c65a.png">

Şehirler GET request API'si ile çekilip listelenmektedir. Search butonu sayesinde arama yapılabilmektedir.

<img width="450" alt="CityFilteringPage" src="https://user-images.githubusercontent.com/24764184/179424347-9a3aaeb8-3235-4814-a93f-ee49d0f2613c.png">

## Filtreleme

Filtreleme Ekranı aşağıdaki gibidir. Ancak fonksiyonel özellikleri çalışmamaktadır. 
<img width="345" alt="Filtreleme" src="https://user-images.githubusercontent.com/24764184/179424383-ab201ddc-fcf4-44b6-b1bb-0c57bc25e488.png">

## Tarih ve Saat Seçme Ekranı

<img width="450" alt="DateAndTimePage" src="https://user-images.githubusercontent.com/24764184/179424421-d82c8cdf-3cc9-4710-96b1-ac348ace9ba6.png">

Randevu Tarihi güncelleme işlemi 

<img width="450" alt="DateSelection" src="https://user-images.githubusercontent.com/24764184/179424443-f1d75ab0-5c0e-4591-8b6e-13a3f76cda91.png">

'Tüm istasyonlar', 'Spesifik İstasyon’un Herhangi bir tarihte Soket & Doluluk Bilgisi', 'Randevu Alma' API kodları geliştirmeleri kodda incelenebilir. Modelleri oluşturulup tam olarak decode işlemi yapılamamıştır.



