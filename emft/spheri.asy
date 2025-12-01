import three;
import graph3;

// Set up 3D view
size(400);
currentprojection=perspective(6,4,4);

// Parameters
real r1 = 4;
real theta1 = 50;  // degrees from z-axis
real phi1 = 45;    // degrees from x-axis

// Convert to radians
real theta1_rad = radians(theta1);
real phi1_rad = radians(phi1);

// Point P in Cartesian coordinates
triple P = (r1*sin(theta1_rad)*cos(phi1_rad), 
            r1*sin(theta1_rad)*sin(phi1_rad), 
            r1*cos(theta1_rad));

// Unit vectors at P
triple ar = (sin(theta1_rad)*cos(phi1_rad), 
             sin(theta1_rad)*sin(phi1_rad), 
             cos(theta1_rad));
             
triple atheta = (cos(theta1_rad)*cos(phi1_rad), 
                 cos(theta1_rad)*sin(phi1_rad), 
                 -sin(theta1_rad));
                 
triple aphi = (-sin(phi1_rad), cos(phi1_rad), 0);

// Draw axes
draw(O--6X, arrow=Arrow3, L=Label("$x$", position=EndPoint));
draw(O--6Y, arrow=Arrow3, L=Label("$y$", position=EndPoint));
draw(O--6Z, arrow=Arrow3, L=Label("$z$", position=EndPoint));

// Draw sphere (r = r1) - partial sphere surface
draw(surface(scale3(r1)*unitsphere), lightgray+opacity(0.3));

// Draw sphere wireframe (meridians and parallels)
int n = 12;
// Draw meridians (lines of constant phi)
for(int i = 0; i < n; ++i) {
    real phi = 2*pi*i/n;
    triple f(real t) {
        return r1*(sin(t)*cos(phi), sin(t)*sin(phi), cos(t));
    }
    draw(graph(f, 0, pi), gray+dashed);
}
// Draw parallels (lines of constant theta)
for(int i = 1; i < n; ++i) {
    real theta = pi*i/n;
    triple g(real t) {
        return r1*(sin(theta)*cos(t), sin(theta)*sin(t), cos(theta));
    }
    draw(graph(g, 0, 2*pi), gray+dashed);
}

// Draw cone surface (theta = theta1)
real cone_radius = r1*sin(theta1_rad);
real cone_height = r1*cos(theta1_rad);

// Circle at constant theta
triple circleF(real t) {
    return (cone_radius*cos(t), cone_radius*sin(t), cone_height);
}
draw(graph(circleF, 0, 2*pi), blue+linewidth(1));

draw(O--P, blue+linewidth(1));
draw(O--(P.x, P.y, -P.z), blue+linewidth(1));
label("$\theta=\theta_1$ surface", (P.x*0.3, P.y*0.3, cone_height*1.2));

// Draw plane (phi = phi1)
real plane_size = 5;
triple plane_corner1 = (0, 0, 0);
triple plane_corner2 = plane_size*(cos(phi1_rad), sin(phi1_rad), 0);
triple plane_corner3 = plane_size*(cos(phi1_rad), sin(phi1_rad), 1);
triple plane_corner4 = (0, 0, plane_size);

draw(surface(plane_corner1--plane_corner2--plane_corner3--plane_corner4--cycle), 
     lightblue+opacity(0.3));
draw(plane_corner1--plane_corner2--plane_corner3--plane_corner4--cycle, blue);
label("$\phi=\phi_1$ plane", plane_corner2 + (0,0,2.5), E);

// Draw radial line from origin to P
draw(O--P, black+linewidth(1.5), arrow=Arrow3(size=3mm));
label("$r_1$", P/2, NW);

// Draw projection lines
draw(P--(P.x, P.y, 0), dashed);
draw(O--(P.x, P.y, 0), dashed);
draw((0,0,P.z)--P, dashed);

// Draw angle phi in xy-plane
path3 phi_arc = arc(O, 3X, 3*(cos(phi1_rad), sin(phi1_rad), 0));
draw(phi_arc, arrow=Arrow3(size=2mm));
label("$\phi_1$", (1.5*cos(phi1_rad/2), 1.5*sin(phi1_rad/2), 0));

// Draw angle theta from z-axis
triple theta_start = 2.5*Z;
triple theta_end = 2.5*ar;
path3 theta_arc = arc(O, theta_start, theta_end);
draw(theta_arc, arrow=Arrow3(size=2mm));
label("$\theta_1$", 2.8*(ar+Z)/2, W);

// Draw point P
dot(P, red+linewidth(6));
label("$P_1(r_1,\theta_1,\phi_1)$", P, NE);

// Draw basis vectors at P
real vec_scale = 1.2;
draw(P--(P+vec_scale*ar), red+linewidth(2), arrow=Arrow3(size=3mm));
label("$\mathbf{a}_r$", P+vec_scale*ar, NE);

draw(P--(P+vec_scale*atheta), blue+linewidth(2), arrow=Arrow3(size=3mm));
label("$\mathbf{a}_\theta$", P+vec_scale*atheta, S);

draw(P--(P+vec_scale*aphi), deepgreen+linewidth(2), arrow=Arrow3(size=3mm));
label("$\mathbf{a}_\phi$", P+vec_scale*aphi, E);
