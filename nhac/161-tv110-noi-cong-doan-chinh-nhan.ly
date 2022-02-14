% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Nơi Cộng Đoàn Chính Nhân" }
  composer = "Tv. 110"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  g8 fs fs16 (g) b8 |
  a8. e16 fs (g) e8 |
  d4. b'16 b |
  c8 a b c |
  d2 ~ |
  d4 r8 c16 c |
  e8 c a c |
  b4. a16 fs |
  fs8 \slashedGrace { \once \stemDown fs16 ^( } g8) a e |
  d4 r8 b'16 b |
  a8 a d fs, |
  g2 \bar "||"
  
  b8 g a g |
  fs8. fs16 a8 b |
  e,4. d16 d |
  d8 d fs g |
  \slashedGrace { b16 ( } a2) ~ |
  a8 a a g |
  fs fs16 a c8 b |
  b2 ~ |
  b8 b c c |
  a a16 d c8 a |
  g2 ~ |
  g4 r \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  g8 fs fs16 (g) b8 |
  a8. e16 fs (g) e8 |
  d4. g16 g |
  a8 fs g a |
  b2 ~ |
  b4 r8 a16 a |
  c8 a fs a |
  g4. e16 e |
  d8 [d] cs cs |
  d4 r8 g16 g |
  fs8 fs e d |
  b2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Nơi cộng đoàn chính nhân và giữa công hội,
  Con xin hết lòng tạ ơn Chúa.
  Sự nghiệp Chúa vô cùng lớn lao,
  công trình Ngài hiển hách oai hùng,
  Đức tín trung kiên vững ngàn năm.
  <<
    {
      \set stanza = "1."
      Chúa truyền ta tưởng niệm kỳ công của Ngài
      vì lòng Ngài từ bi nhân ái.
      Ai tôn sợ Ngài, Ngài ban phát muôn ơn,
      Giao ước đã lập Ngài khắc ghi muôn đời.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Sức mạnh công việc ngài thần dân ngắm nhìn,
	    Ngài tặng họ sản nghiệp muôn nước,
	    Bao uy công Ngài thực ngay chính quang minh,
	    Ban bố huấn lệnh ngàn kiếp không đổi dời.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Chúa lập minh giao Ngài ngàn năm vững bền,
	    Thực kỳ diệu, thần thiêng danh Chúa,
	    Biết kính sợ Ngài là đầu mối khôn ngoan,
	    Ai sáng suốt thực thì tín trung thi hành.
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
    \override Lyrics.LyricSpace.minimum-distance = #0.8
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
