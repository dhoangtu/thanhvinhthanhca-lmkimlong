% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Xin Lấy Uy Danh" }
  composer = "Tv. 53"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 8 g8 |
  a8. g16 fs8 e ~ |
  e d b' g |
  a2 |
  c8. a16 a8 a ~ |
  a c a16 (c) d8 |
  d2 |
  r8 b b d |
  b8. a16 e8 e ~ |
  e g e e |
  d8. fs16 a8 g ~ |
  g4 \bar "||" \break
  
  g8. a16 |
  fs8 e4 d8 |
  b'4 r8 b |
  a d b (a) |
  g8. b16 a (g) e8 |
  e2 ~ |
  e4 g8. e16 |
  d8 fs4 g8 |
  a4 r8 c |
  c c c (e) |
  a,8. a16 fs (e) d8 |
  g2 ~ |
  g4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  g8 |
  a8. g16 fs8 e ~ |
  e d g e |
  d2 |
  c'8. a16 a8 a ~ |
  a a fs16 (a) g8 |
  fs2 |
  r8 g g fs |
  g8. d16 c8 c ~ |
  c e c c |
  b8. d16 c8 b ~ |
  b4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Xin lấy uy danh Ngài mà cứu độ con,
  Xin dùng quyền lực phân xử cho con.
  Xin nghe tiếng con nay nguyện cầu,
  lắng tai nghe lời con kính thân.
  <<
    {
      \set stanza = "1."
      Bao lũ kiêu ngạo vùng đứng
      Đương đầu với con và muốn con tuyệt mạng,
      Chúng không kể chi Thiên Chúa,
      Nhưng thân con Chúa hằng đỡ nâng chở che.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Con ước mong rằng bọn chúng
	    Truy nhận chính những điều chúng mưu hại người.
	    Chúa muôn đời luôn trung tín,
	    Xin giơ tay tiễu trừ chũng khỏi trần ai.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Con tiến dâng Ngài của lễ
	    Ca tụng thánh danh Ngài,
	    thánh danh thiện toàn,
	    Cứu con khỏi mọi gian nguy,
	    Cho con kiêu hãnh nhìn hết mọi thù nhân.
    }
  >>
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 3\mm
  bottom-margin = 3\mm
  left-margin = 3\mm
  right-margin = 3\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  page-count = #1
}

TongNhip = {
  \key g \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
}

% Đổi kích thước nốt cho bè phụ
notBePhu =
#(define-music-function (font-size music) (number? ly:music?)
   (for-some-music
     (lambda (m)
       (if (music-is-of-type? m 'rhythmic-event)
           (begin
             (set! (ly:music-property m 'tweaks)
                   (cons `(font-size . ,font-size)
                         (ly:music-property m 'tweaks)))
             #t)
           #f))
     music)
   music)

\score {
  \new ChoirStaff <<
    \new Staff \with {
        \consists "Merge_rests_engraver"
        printPartCombineTexts = ##f
      }
      <<
      \new Voice \TongNhip \partCombine 
        \nhacPhienKhucSop
        \notBePhu -1 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    %\override Staff.TimeSignature.transparent = ##t
    \override Lyrics.LyricSpace.minimum-distance = #1
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
