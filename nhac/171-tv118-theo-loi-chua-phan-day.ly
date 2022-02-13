% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Theo Lời Chúa Phán Dạy" }
  composer = \markup {
    \column {
      \line { "Tv. 118" }
      \line { "đoạn 2 (câu 9-15)"  }
    }
  }
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 8 d8 |
  g a16 fs g8 a |
  b4 r8 a16 fs |
  g8 e a a |
  d,4 r8 d |
  b' b16 c a8 g |
  e'4. a,16 a |
  c8 c d d |
  g,4 r8 \bar "||"
  
  fs |
  g8. a16 e8 d |
  b' b r c16 a |
  fs8 fs d'16 (e) e8 |
  d4 r8 c |
  b8. b16 b8 g |
  d' fs, r g16 e |
  d8 fs a fs |
  g4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  d8 |
  g a16 fs g8 a |
  b4 r8 a16 fs |
  g8 e a a |
  d,4 r8 d |
  g8 g16 a fs8 e |
  c'4. c,16 c |
  e8 e fs fs |
  g4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Làm sao giữ tuổi xuân trong trắng?
  Thưa phải theo lời Chúa phán dạy.
  Lạy Chúa, con hết tâm tìm Chúa,
  đừng để con xa huấn giới Ngài.
  <<
    {
      \set stanza = "1."
      Lòng con ấp ủ lời Chúa hứa
      Để không hề bội nghĩa bất trung,
      Chúa ơi con dâng lời tán tụng,
      Thánh chỉ Ngài xin hãy dạy con.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Miệng con vẫn liên lỉ nhắc nhớ
	    Các qui định miệng Chúa phán ra,
	    Sướng vui con tuân hành ý Ngài,
	    Vẫn hơn được tiền lắm bạc dư.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Niệm suy huấn lệnh Ngài phát quyết,
	    Mắt con nhìn đường lối Chúa luôn,
	    Quyết tâm không quên lời Chúa dạy,
	    Thánh chỉ Ngài con lấy làm vui.
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 3))
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
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
