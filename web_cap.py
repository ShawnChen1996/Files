import os, cv2, time, struct, threading
from http.server import HTTPServer, BaseHTTPRequestHandler
from threading import Thread, RLock # threading
#from socketserver import Thread, RLock # threading
from select import select


class JpegStreamer(Thread):
    def __init__(self, camera):
        super().__init__()
        self.cap = cv2.VideoCapture(camera)
        self.lock = RLock()
        self.pipes = {}
    
    def register(self):
        pr, pw = os.pipe()
        self.lock.acquire()
        self.pipes[pr] = pw
        self.lock.release()
        return pr
        
    def unregister(self, pr):
        self.lock.acquire()
        self.pipes.pop(pr)
        self.lock.release()
        pr.close()
        pw.close()

    def capture(self):
        cap = self.cap
        while cap.isOpened():
            ret, frame = cap.read()
            if ret:
                data = cv2.imencode('.jpg',
                frame, (cv2.IMWRITE_JPEG_QUALITY, 40))
                yield data[1]

    def send(self, frame):
        n = struct.pack('l', len(frame))
        self.lock.acquire()
        if len(self.pipes):
            _, pipes, _ = select([].self.pipes.itervalues(),[],1)
            for pipe in pipes:
                os.write(pipe,n)
                os.write(pipe,frame)

            self.lock.release()

    def run(self):
        for frame in self.capture():
            self.send(frame)

    
class JpegRetriever():
    def __init__(self, streamer):
        self.streamer = streamer
        self.pipe = streamer.register()

    def retrieve(self):
        while 1:
            ns = os.read(self.pipe, 8)
            n = struct.unpack('l', ns)[0]
            data = os.read(self.pipe,n)
            yield data

    def cleanup(self):
        self.streamer.unregister(self.pipe)

class Handler(BaseHTTPRequestHandler):
    retriever = None
    @staticmethod
    def setJpegRetriever(self):
        Handler.retriever = retriever

    def do_GET(self):
        if self.retriver is None:
            raise RuntimeError('No retriever')
        
        if self.path != '/':
            return
        
        self.send_response(200)
        self.send_header('Content-type', 'multipart/x-mixed-replace;boundary=abcde')
        self.send_headers()

        for frame in self.retriever.retrieve():
            self.send_frame(frame)

    def send_frame(self, frame):
        self.wfile.write('--abcde\r\n')
        self.wfile.write('Content-Type: image/jpeg\r\n')
        self.wfile.write('Content-Length: %d' %len(frame))
        self.wfile.write(frame)

if __name__ == '__main__':
    streamer = JpegStreamer(0)
    streamer.start()
    retriever = JpegRetriever(streamer)
    Handler.setJpegRetriever(retriever)
    print('starting...')
    httpd = HTTPServer(('',9000), Handler)
    httpd.server_forever()

