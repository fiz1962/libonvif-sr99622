#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "onvif.h"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
}

MainWindow::~MainWindow()
{
    delete ui;
}


void MainWindow::on_pushButton_clicked()
{
    struct OnvifSession *onvif_session = (struct OnvifSession*)malloc(sizeof(struct OnvifSession));
    struct OnvifData *onvif_data = (struct OnvifData*)malloc(sizeof(struct OnvifData));
    initializeSession(onvif_session);

    clearData(onvif_data);
    strncpy(onvif_data->camera_name, "UNKNOWN CAMERA", strlen(onvif_data->camera_name));
    strcpy(onvif_data->device_service, "POST /onvif/device_service HTTP/1.1");
    strcpy(onvif_data->xaddrs, "http://192.168.1.100:80/onvif/device_service");

    strcpy(onvif_data->username, "user");
    strcpy(onvif_data->password, "passwd");

    extractOnvifService(onvif_data->device_service, true);
    getTimeOffset(onvif_data);

// time_offset not set correctly for some cameras? so set = 0 explicitely if needed
qDebug() << "Time offset " << onvif_data->time_offset;

    onvif_data->time_offset = 0;

    fillRTSP(onvif_data);
ui->textEdit->append( onvif_data->stream_uri );
ui->textEdit->append( onvif_data->xaddrs );
ui->textEdit->append( onvif_data->device_service );


    closeSession(onvif_session);
    free(onvif_session);
    free(onvif_data);
}

void MainWindow::on_pushButton_2_clicked()
{
    struct OnvifSession *onvif_session = (struct OnvifSession*)malloc(sizeof(struct OnvifSession));
    struct OnvifData *onvif_data = (struct OnvifData*)malloc(sizeof(struct OnvifData));
    initializeSession(onvif_session);
    int number_of_cameras = broadcast(onvif_session);
    fprintf(stdout, "libonvif found %d cameras\n", number_of_cameras);

    for (int i = 0; i < number_of_cameras; i++) {
      prepareOnvifData(i, onvif_session, onvif_data);

      ui->textEdit->append(onvif_data->camera_name);
      /*fprintf(stdout, "enter username:");
      fgets(onvif_data->username, 128, stdin);
      fprintf(stdout, "enter password:");
      fgets(onvif_data->password, 128, stdin);

      onvif_data->username[strcspn(onvif_data->username, "\r\n")] = 0;
      onvif_data->password[strcspn(onvif_data->password, "\r\n")] = 0;

      if (fillRTSP(onvif_data) == 0)
          fprintf(stdout, "%s\n", onvif_data->stream_uri);
      else
          fprintf(stderr, "Error getting camera uri - %s\n", onvif_data->last_error);
*/
    }

    closeSession(onvif_session);
    free(onvif_session);
    free(onvif_data);
}
