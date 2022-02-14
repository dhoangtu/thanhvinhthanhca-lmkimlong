% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Chúa Đổi Vận Mạng Dân Ngài" }
  composer = "Tv. 13"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 4 e16 (g) f8 |
  e4. d8 f e |
  c4. c8 c a' |
  a2. |
  c4. b8 a4 |
  f4. d8 d f |
  g2 e16 (g) f8 |
  f4. d8 f e |
  c4. c8 c a' |
  a2. |
  c4. b8 a4 |
  f4. d8 d g |
  c,2. \bar "||"
  
  g'8. a16 f8 f f g |
  e2 d8 e |
  f4. d8 c g' |
  g2. |
  d'8. e16 c8 c c d |
  b2 c8 b |
  a4. a8 b g |
  c2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r4 |
  R2.*12
  
  e8. f16 d8 d d b |
  c2 g8 c |
  d4. b8 a c |
  b2. |
  g'8. gs16 a8 a a fs |
  g2 e8 e |
  f4. f8 f f |
  e2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Kẻ ngu si tự nhủ trong lòng:
      làm gì có Chúa,
      Chúng ra suy đồi, hành động tanh hôi.
      Ở thiên cung Thượng Đế trông nhìn
      loài người dưới thế có ai lương thiện
      còn tìm kiếm Ngài
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Phải chăng nay toàn thể nhân trần
	    lìa đường chính nghĩa,
	    nhưng theo nhay để hành động vô luân,
	    chẳng trông đâu một kẻ trung thành
	    làm việc phúc đức,
	    Dẫu cho chỉ một mà nào có còn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Kẻ gian manh độc dữ vô nghì chẳng cầu khấn Chúa,
	    sống trên xương tủy của đồng bào ta.
	    Chẳng bao xa họ sẽ kinh hoàng
	    vì quyền phép Chúa,
	    Đấng luôn nghe lời người nghèo khấn cầu.
    }
  >>
  \set stanza = "ĐK:"
  Khi Chúa đổi vận mạng dân Ngài,
  nhà Gia -- cop vui mừng biết mấy,
  Khi Chúa đổi vận mạng dân Ngài,
  Is -- ra -- el vui sướng dường bao.
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
}

TongNhip = {
  \key c \major \time 3/4
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
    \override Lyrics.LyricSpace.minimum-distance = #0.9
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
