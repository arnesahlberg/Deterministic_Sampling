from __future__ import division
from numpy import *
from scipy.linalg import *
import sys
import os

def hadamard(n):
    k=0

    while (n > 1 and fix_(n / 2) == n / 2):
        k += 1
        n /= 2

    if (n != 1):
        k -= 2
    if (k < 0):
        n=- 1
    if 1 == (n):
        h=array([[1]])
    else:
        if 3 == (n):
            h=h12_()
        else:
            if 5 == (n):
                h=h20_()
            else:
                if 7 == (n):
                    h=h28_()
                else:
                    raise Exception('hadamard: n must be 2^k*p, for p = 1, 12, 20 or 28')
    h2=array([[1,1],[1,- 1]])
    while (True):

        if (fix_(k / 2) != k / 2):
            h=kron(h2,h)
        k=fix_(k / 2)
        if (k == 0):
            break
        h2=kron(h2,h2)

    return h


def h12_(nargout=1):
    tu=array([- 1,+ 1,- 1,+ 1,+ 1,+ 1,- 1,- 1,- 1,+ 1,- 1])
    tl=array([- 1,- 1,+ 1,- 1,- 1,- 1,+ 1,+ 1,+ 1,- 1,+ 1])
    h=ones([12,12])
    h[1:h.shape[0],1:h.shape[1]]=toeplitz(tu,tl)
    return h
def h20_(nargout=1):
    tu=array([+ 1,- 1,- 1,+ 1,+ 1,+ 1,+ 1,- 1,+ 1,- 1,+ 1,- 1,- 1,- 1,- 1,+ 1,+ 1,- 1,- 1])
    tl=array([+ 1,- 1,- 1,+ 1,+ 1,- 1,- 1,- 1,- 1,+ 1,- 1,+ 1,- 1,+ 1,+ 1,+ 1,+ 1,- 1,- 1])
    h=ones([20,20])
    h[1:h.shape[0],1:h.shape[1]]=fliplr(toeplitz(tu,tl))
    return h
def h28_(nargout=1):
    h=array([1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,- 1,- 1,- 1,- 1,- 1,- 1,- 1,1,- 1,- 1,- 1,1,1,1,1,1,- 1,1,1,1,1,- 1,1,- 1,1,- 1,1,- 1,1,- 1,- 1,- 1,- 1,1,- 1,1,1,- 1,- 1,1,- 1,- 1,- 1,- 1,1,1,- 1,1,- 1,1,1,1,1,1,1,- 1,- 1,1,- 1,- 1,- 1,1,1,1,1,1,- 1,1,1,1,1,1,- 1,- 1,- 1,- 1,- 1,- 1,- 1,1,- 1,1,1,- 1,- 1,- 1,1,- 1,- 1,1,1,- 1,1,1,1,1,1,- 1,- 1,- 1,1,1,1,- 1,1,- 1,1,- 1,- 1,- 1,1,- 1,- 1,- 1,- 1,1,- 1,1,1,- 1,- 1,1,1,- 1,- 1,- 1,1,1,- 1,- 1,- 1,1,1,1,1,1,1,- 1,1,- 1,- 1,- 1,- 1,- 1,1,- 1,1,- 1,- 1,- 1,1,- 1,1,1,1,- 1,1,1,1,1,- 1,1,- 1,1,- 1,1,1,- 1,1,1,1,1,- 1,- 1,1,- 1,- 1,- 1,- 1,1,1,1,- 1,- 1,- 1,- 1,1,- 1,- 1,1,1,1,1,- 1,1,- 1,- 1,1,1,1,1,1,- 1,- 1,- 1,- 1,- 1,1,- 1,- 1,- 1,1,- 1,1,1,1,1,- 1,- 1,1,- 1,1,1,1,1,1,- 1,- 1,- 1,- 1,- 1,- 1,1,1,1,- 1,1,- 1,- 1,- 1,- 1,- 1,1,1,1,- 1,- 1,1,1,1,1,- 1,1,1,1,- 1,- 1,- 1,- 1,1,- 1,1,1,- 1,- 1,- 1,1,1,- 1,1,1,- 1,- 1,1,1,- 1,- 1,1,1,- 1,- 1,1,1,1,- 1,- 1,- 1,1,1,- 1,1,- 1,- 1,1,1,- 1,1,1,- 1,- 1,1,- 1,- 1,1,1,- 1,1,- 1,- 1,- 1,1,1,1,- 1,- 1,1,1,1,- 1,- 1,1,1,- 1,- 1,- 1,- 1,- 1,1,1,1,1,- 1,- 1,1,1,1,1,1,1,- 1,- 1,1,1,- 1,- 1,- 1,- 1,- 1,- 1,1,1,- 1,1,- 1,- 1,1,1,- 1,1,- 1,- 1,1,1,1,- 1,1,1,- 1,1,- 1,1,- 1,1,1,- 1,1,- 1,- 1,1,- 1,- 1,1,- 1,1,- 1,1,- 1,- 1,1,- 1,1,1,- 1,1,- 1,- 1,1,- 1,1,1,1,- 1,- 1,- 1,- 1,- 1,- 1,1,1,- 1,1,- 1,1,1,1,1,- 1,- 1,1,1,- 1,1,- 1,1,1,1,1,1,- 1,- 1,1,- 1,1,- 1,- 1,- 1,- 1,1,- 1,- 1,- 1,- 1,1,- 1,1,1,1,1,- 1,1,- 1,1,- 1,1,- 1,1,- 1,1,1,1,- 1,1,- 1,- 1,1,- 1,1,1,- 1,1,- 1,- 1,- 1,- 1,1,- 1,1,- 1,1,- 1,1,1,1,1,1,- 1,1,- 1,- 1,1,- 1,1,- 1,- 1,1,1,- 1,- 1,- 1,- 1,1,- 1,1,1,1,- 1,1,- 1,1,1,- 1,1,- 1,- 1,1,1,1,- 1,1,- 1,- 1,- 1,- 1,- 1,1,1,- 1,1,- 1,- 1,1,1,- 1,- 1,1,- 1,1,- 1,- 1,- 1,- 1,1,1,1,- 1,1,- 1,1,1,- 1,- 1,- 1,- 1,- 1,1,1,1,1,1,1,1,- 1,- 1,1,1,1,- 1,- 1,1,1,- 1,- 1,- 1,1,1,- 1,- 1,1,1,- 1,- 1,- 1,1,1,- 1,- 1,1,1,- 1,- 1,1,1,- 1,1,- 1,- 1,1,- 1,- 1,- 1,1,- 1,1,1,1,- 1,1,- 1,- 1,1,- 1,- 1,1,1,1,- 1,1,- 1,- 1,1,1,- 1,1,1,- 1,1,- 1,1,- 1,- 1,1,- 1,1,- 1,1,- 1,1,- 1,- 1,- 1,1,1,1,1,1,- 1,1,1,- 1,- 1,1,1,- 1,1,- 1,- 1,1,- 1,- 1,1,1,1,- 1,1,- 1,- 1,- 1,1,- 1,- 1,1,- 1,1,1,- 1,1,1,- 1,- 1,- 1,1,- 1,1,1,1,- 1,1,1,1,- 1,- 1,1,- 1,- 1,1,- 1,- 1,- 1,1,1,1,- 1,- 1,1,- 1,- 1,1,- 1,1,- 1,1,1,- 1,1,- 1,1,- 1,1,- 1,- 1,1,1,- 1,- 1,- 1,1,1,- 1,1,1,- 1,- 1,1,1,- 1,- 1,- 1,1,- 1,- 1,1,1,- 1,1,1,1,- 1,- 1,1,1,- 1,- 1,1,- 1])
    return h.reshape([len(h)/28, 28])

def fix_(a):
    return float(int(a))

def goodHadamardMatrixNumber(n):
    ps = [1,12,20,28]
    for p in ps:
        x = log2(1.0*n/p)
        if (ceil(x) == x and x >= 0):
            return True
    return False

    return mod(n,4) == 0 or mod(n,12) == 0 or mod(n,20) == 0 or mod(n,28) == 0

def BinaryEnsMatrix(n, shuffle=True):
    n = int(n)
    if (n == 1):
        return array([[1],[-1]])
    N = n+1 # need this many hadamard rows
    while not goodHadamardMatrixNumber(N):
        N = N+1
    H = hadamard(N)
    M = H[:, 1:n+1]

    if shuffle and n > 2:
        for i in range(0,columns(M)):
            if (random.random()<0.5):
                M[:,i] = -M[:,i]

    return M


def ExtendedBinaryEnsMatrix(n, shuffle=True):
  n = int(n)
  if (n==1):
    return array([[1],[-1]])
  N = n
  while not goodHadamardMatrixNumber(N):
    N = N+1
  H = hadamard(N)[:,0:n]
  M = zeros([2*rows(H), n])
  flH = - flipud(H)
  M[0:rows(H),:] = H[0:rows(H),:]
  M[rows(H):,:] = flH[0:rows(H),:]
  return M

def swapRows(M,r1,r2):
    temp = M[r1,:].copy()
    M[r1,:] = M[r2,:]
    M[r2,:] = temp
    return M

def swapColumns(M, c1, c2):
    temp = M[:,c1].copy()
    M[:,c1] = M[:,c2]
    M[:,c2] = temp
    return M

def BinaryEnsembleStandard(n, shuffle=True):
    q = BinaryEnsMatrix(n, shuffle)
    w = ones([rows(q), 1]) / rows(q)
    return q,w

def Gauss4momentEnsembleStandard(n, shuffle=True):
    if n == 1:
        return sqrt(3) * matrix([[1],[-1],[0]]) , matrix([[1.0/6, 1.0/6, 2.0/3]]).T
    elif n == 2:
        return sqrt(3) * matrix([[1, 0],[-1, 0],[0, 1],[0, -1],[0, 0]]) , matrix([[1.0/6, 1.0/6, 1/6, 1/6, 1.0/3]]).T

    d = floor(n/3.0)
    r = remainder(n,3.0)
    a = d
    b = d
    c = d
    if (r>0):
        a = a+1
        r = r-1
    if (r > 0):
        b = b+1

    Ca = BinaryEnsMatrix(a, shuffle)
    Cb = BinaryEnsMatrix(b, shuffle)
    Cc = BinaryEnsMatrix(c, shuffle)

    q = zeros([rows(Ca) + rows(Cb) + rows(Cc) , columns(Ca) + columns(Cb) + columns(Cc)])

    q[0:rows(Ca), 0:columns(Ca)] = Ca * sqrt(3)
    q[rows(Ca):(rows(Ca)+rows(Cb)), columns(Ca):(columns(Ca) + columns(Cb))] = Cb * sqrt(3)
    q[(rows(Ca)+rows(Cb)):(rows(Ca)+rows(Cb)+rows(Cc)), (columns(Ca)+columns(Cb)):(columns(Ca)+columns(Cb)+columns(Cc))] = Cc * sqrt(3)

    w = zeros([rows(q), 1])
    k = 0
    n1 = rows(Ca)
    for i in range(0,n1):
        w[k] = 1.0 / (3*n1)
        k = k+1
    n2 = rows(Cb)
    for i in range(0,n2):
        w[k] = 1.0 / (3*n2)
        k = k+1
    n3 = rows(Cc)
    for i in range(0,n3):
        w[k] = 1.0/ (3*n3)
        k = k+1


    if shuffle and n > 2:
        N = len(q[:,0])
        for i in range(0,N):
            r1 = random.randint(N)
            r2 = random.randint(N)
            while (r1 == r2):
                r2 = random.randint(N)
            q = swapRows(q, r1, r2)
            w = swapRows(w, r1, r2)
        n = len(q[0,:])
        for i in range(0,n):
            r1 = random.randint(n)
            r2 = random.randint(n)
            while (r1 == r2):
                r2 = random.randint(n)
            q = swapColumns(q, r1, r2)

    return q, w

def BinaryEnsemble(mus, sigs, shuffle=True):
    n = len(mus)
    base, w = BinaryEnsembleStandard(n, shuffle)
    M = zeros_like(base)
    S = zeros([n,n])
    for i in range(0,n):
        M[:,i] = mus[i]
        S[i,i] = sigs[i]
    q = array(matrix(base) * S + M )
    return q , w

def Gauss4momentEnsemble(mus, sigs, shuffle=True):
    n = len(mus)
    base, w = Gauss4momentEnsembleStandard(n, shuffle)
    M = zeros_like(base)
    S = zeros([n,n])
    for i in range(0,n):
        M[:,i] = mus[i]
        S[i,i] = sigs[i]
    q = array(matrix(base) * S + M )
    return q , w

def Gauss6momentEnsemble(mus, sigs, shuffle=True, extended=False):
    n = len(mus)
    base, w = Gauss6momentEnsembleStandard(n, shuffle, extended)
    M = zeros_like(base)
    S = zeros([n,n])
    for i in range(0,n):
        M[:,i] = mus[i]
        S[i,i] = sigs[i]
    q = array(matrix(base) * S + M )
    return q , w


def Gauss6momentSimple(mus, sigs):
    n = len(mus)
    q0,w0 = Gauss6momentEnsembleStandard(1)
    qpm = q0[0:4] ; wpm = w0[0:4]
    N = n * 4 + 1
    q = zeros([N,n]) ; w = zeros([N,1]) ;
    for i in range(0,n):
        i0 = i * 4
        i1 = i * 4 + 4
        k = 0;
        for j in range(i0, i1):
            q[j , i] = qpm[k]
            w[j , 0] = wpm[k]
            k = k+1;
    w[-1] = 1 - sum(w)
    M = zeros_like(q)
    S = zeros([n,n])
    for i in range(0,n):
        M[:,i] = mus[i]
        S[i,i] = sigs[i]
    q = array(matrix(q) * S + M )
    return q , w

def Gauss8momentSimple(mus, sigs):
    n = len(mus)
    q0 = array(matrix(array([-3., -2., -sqrt(3./2), sqrt(3./2), 2., 3.,0])).T)
    w0 = array(matrix(array([1./150, 3./100., 16./75, 16./75, 3./100, 1./150,1./2])).T)
    qpm = q0[0:6] ; wpm = w0[0:6]
    N = n * 6 + 1
    q = zeros([N,n]) ; w = zeros([N,1]) ;
    for i in range(0,n):
        i0 = i * 6
        i1 = i * 6 + 6
        k = 0;
        for j in range(i0, i1):
            q[j , i] = qpm[k]
            w[j , 0] = wpm[k]
            k = k+1;
    w[-1] = 1 - sum(w)
    M = zeros_like(q)
    S = zeros([n,n])
    for i in range(0,n):
        M[:,i] = mus[i]
        S[i,i] = sigs[i]
    q = array(matrix(q) * S + M )
    return q , w
    
	

def Gauss6momentEnsembleStandard(n, shuffle=True, extended=False):
    if n == 1:
        q = array([[3],[sqrt(2)],[0],[-sqrt(2)],[-3]])
        w = array([[1.0/126],[3.0/14],[5.0/9],[3.0/14],[1.0/126]])
        return q,w

    part1 = ceil(n/2)
    part2 = floor(n/2)
    
    if extended:
      C1 = ExtendedBinaryEnsMatrix(part1)
      C2 = ExtendedBinaryEnsMatrix(part2)
    else :
      C1 = BinaryEnsMatrix(part1)
      C2 = BinaryEnsMatrix(part2)

    pad1c = len(C1[0,:])
    pad2c = len(C2[0,:])
    pad1r = len(C1[:,0])
    pad2r = len(C2[:,0])

    f2 = 3.0
    f1 = sqrt(2)
    w2 = 1.0 / 126
    w1 = 3.0/14
    w0 = 2.0/9 

    q = zeros([2 * pad1r + 2 * pad2r + 1, pad1c + pad2c])

    q[0:pad1r, 0:pad1c] = f2 * C1
    q[pad1r:pad1r + pad2r, pad1c:pad1c + pad2c] = f2 * C2
    q[pad1r + pad2r:pad1r + pad2r + pad1r, 0:pad1c] = f1 * C1
    q[pad1r + pad2r + pad1r:pad1r + pad2r + pad1r + pad2r, pad1c:pad1c + pad2c] = f1 * C2

    N = len(q[:,0])
    w = zeros([N,1])
    k = 0
    for i in range(0,2*pad1r):
        w[k,0] = w2 / pad1r * 2
        k = k+1
    for i in range(0,2*pad2r):
        w[k,0] = w1 / pad2r * 2
        k = k+1
    w[-1,0] = w0/2


    if shuffle and n > 2:
        N = len(q[:,0])
        for i in range(0,N):
            r1 = random.randint(N)
            r2 = random.randint(N)
            while (r1 == r2):
                r2 = random.randint(N)
            q = swapRows(q, r1, r2)
            w = swapRows(w, r1, r2)
        n = len(q[0,:])
        for i in range(0,n):
            r1 = random.randint(n)
            r2 = random.randint(n)
            while (r1 == r2):
                r2 = random.randint(n)
            q = swapColumns(q, r1, r2)

    return q,w


def rows(A):
    return len(A[:,0])
def columns(A):
    return len(A[0,:])



def weightedMean(q,w):
    return array(w.T * matrix(q))

def weightedMoment(q,w,n):
    if (n == 1):
        return weightedMean(q,w)
    else:
        return array(w.T * matrix((q - weightedMean(q,w))**n))


def weightedMoments(q,w,num):
    moms = zeros([num, columns(array(q))])
    for i in range(1,num+1):
        a = weightedMoment(q,w,i)
        moms[i-1, :] = a[0,:]
    return moms


def print4momEns(n, shuffle=True):
    f = open("gaussenstemp", "w")
    fw = open("gaussenstempW", "w")

    q,w = Gauss4momentEnsembleStandard(n, shuffle)
    f.write(str(rows(q)) + "\n" + str(columns(q)) + "\n")
    fw.write(str(rows(w)) + "\n" + str(columns(w)) + "\n")

    for i in range(0,rows(q)):
        for j in range(0,columns(q)):
            f.write(str(q[i,j]) + "    ")
        f.write("\n")
        fw.write(str(w[i,0]) + "\n")

    f.close()
    fw.close()


if __name__ == "__main__":
    print 'DSGaussEns'
