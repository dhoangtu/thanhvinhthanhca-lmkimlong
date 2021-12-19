% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = "Lời Chúa Là Đèn Soi Con"
  composer = \markup {
    \column {
      \line { "Tv. 118" }
      \line { "đoạn 14 (câu 105-112)"  }
    }
  }
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 4. d8 b' g |
  g b16 b b8 c |
  c4 a8 d |
  e8. c16 a8 b |
  b2 ~ 
  b4 d8 d |
  g,8 a16 a a8 b |
  e,4 a8 a |
  d,8. a'16 a8 b |
  g2 ~ |
  g4 r8 \bar "||"
  
  g8 |
  g8 fs16 g e8 ef |
  d4. d16 b |
  d8 b' c b |
  a2 ~ |
  a4 r8 c |
  a a16 g fs8 d' |
  d4. b16 b |
  c8 d b16 (a) fs8 |
  g2 ~ |
  g8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  d8 b' g |
  g g16 g g8 a |
  a4 fs8 g |
  c8. a16 fs8 fs |
  g2 ~ |
  g4 fs8 fs |
  e e16 e d8 d |
  c4 c8 c |
  b8. c16 d8 d |
  b2 ~ |
  b4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Lời Chúa là đèn soi cho con tiến bước,
  là ánh sáng chỉ đường con đi.
  Đã ước nguyện nên nay con hết lòng
  giữ quyết định công minh của Ngài.
  <<
    {
      \set stanza = "1."
      Thân con bị muôn vàn khổ nhục,
      theo lời Ngài xin cứu sống con,
      Khứng nhận lời cảm tạ con dâng
      Và dạy con chứng tri của Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Kiếp sống vương mắc bao hiểm nghèo,
	    nhưng lệnh Ngài con vẫn không quên,
	    Ác nhân giăng bẫy dò quanh con,
	    Luật Ngài con quyết không lìa xa.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Ý Chúa là gia nghiệp trọn đời,
	    gieo vào lòng con những hân hoan,
	    Quyết tâm luôn thi hành thánh ước
	    Mà lòng con hướng theo chẳng ngơi.
    }
  >>
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 10\mm
  bottom-margin = 10\mm
  left-margin = 10\mm
  right-margin = 10\mm
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
        \notBePhu -3 { \nhacPhienKhucAlto }
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
