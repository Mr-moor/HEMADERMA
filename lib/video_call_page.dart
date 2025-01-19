import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class UserVideoPage extends StatefulWidget {
  @override
  _UserVideoPageState createState() => _UserVideoPageState();
}

class _UserVideoPageState extends State<UserVideoPage> {
  CameraController? _cameraController;
  bool isRecording = false;
  bool isMuted = false;
  bool isFrontCamera = true;

  @override
  void initState() {
    super.initState();
    _initializeCamera(isFrontCamera: true); // Start with front camera
  }

  Future<void> _initializeCamera({required bool isFrontCamera}) async {
    final cameras = await availableCameras();
    final selectedCamera = isFrontCamera ? cameras.first : cameras.last;

    _cameraController = CameraController(
      selectedCamera,
      ResolutionPreset.high,
    );

    await _cameraController?.initialize();
    setState(() {});
  }

  void _startRecording() async {
    if (_cameraController != null) {
      await _cameraController?.startVideoRecording();
      setState(() {
        isRecording = true;
      });
    }
  }

  void _stopRecording() async {
    if (_cameraController != null && isRecording) {
      await _cameraController?.stopVideoRecording();
      setState(() {
        isRecording = false;
      });
    }
  }

  void _toggleMute() {
    setState(() {
      isMuted = !isMuted;
    });
  }

  void _flipCamera() async {
    isFrontCamera = !isFrontCamera;
    await _initializeCamera(isFrontCamera: isFrontCamera);
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Video Call'),
      ),
      body: Column(
        children: [
          if (_cameraController != null && _cameraController!.value.isInitialized)
            Expanded(
              child: CameraPreview(_cameraController!),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SingleChildScrollView( // Prevent vertical overflow
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: _buildControlButton(
                          icon: Icons.videocam_off,
                          label: isRecording ? 'Stop Video' : 'Start Video',
                          onTap: isRecording ? _stopRecording : _startRecording,
                          color: Colors.red,
                        ),
                      ),
                      Expanded(
                        child: _buildControlButton(
                          icon: isMuted ? Icons.mic_off : Icons.mic,
                          label: isMuted ? 'Unmute' : 'Mute',
                          onTap: _toggleMute,
                          color: Colors.blue,
                        ),
                      ),
                      Expanded(
                        child: _buildControlButton(
                          icon: Icons.flip_camera_ios,
                          label: 'Flip Camera',
                          onTap: _flipCamera,
                          color: Colors.orange,
                        ),
                      ),
                      Expanded(
                        child: _buildControlButton(
                          icon: Icons.call_end,
                          label: 'End Call',
                          onTap: () {
                            Navigator.pop(context);
                          },
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required Color color,
  }) {
    return Column(
      children: [
        FloatingActionButton(
          onPressed: onTap,
          backgroundColor: color,
          child: Icon(icon),
        ),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
