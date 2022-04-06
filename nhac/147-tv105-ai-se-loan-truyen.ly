% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Ai Sẽ Loan Truyền" }
  composer = "Tv. 105"
  tagline = ##f
}

% mã nguồn cho những chức năng chưa hỗ trợ trong phiên bản lilypond hiện tại
% cung cấp bởi cộng đồng lilypond khi gửi email đến lilypond-user@gnu.org
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

% in số phiên khúc trên mỗi dòng
#(define (add-grob-definition grob-name grob-entry)
     (set! all-grob-descriptions
           (cons ((@@ (lily) completize-grob-entry)
                  (cons grob-name grob-entry))
                 all-grob-descriptions)))

#(add-grob-definition
    'StanzaNumberSpanner
    `((direction . ,LEFT)
      (font-series . bold)
      (padding . 1.0)
      (side-axis . ,X)
      (stencil . ,ly:text-interface::print)
      (X-offset . ,ly:side-position-interface::x-aligned-side)
      (Y-extent . ,grob::always-Y-extent-from-stencil)
      (meta . ((class . Spanner)
               (interfaces . (font-interface
                              side-position-interface
                              stanza-number-interface
                              text-interface))))))

\layout {
    \context {
      \Global
      \grobdescriptions #all-grob-descriptions
    }
    \context {
      \Score
      \remove Stanza_number_align_engraver
      \consists
        #(lambda (context)
           (let ((texts '())
                 (syllables '()))
             (make-engraver
              (acknowledgers
               ((stanza-number-interface engraver grob source-engraver)
                  (set! texts (cons grob texts)))
               ((lyric-syllable-interface engraver grob source-engraver)
                  (set! syllables (cons grob syllables))))
              ((stop-translation-timestep engraver)
                 (for-each
                  (lambda (text)
                    (for-each
                     (lambda (syllable)
                       (ly:pointer-group-interface::add-grob
                        text
                        'side-support-elements
                        syllable))
                     syllables))
                  texts)
                 (set! syllables '())))))
    }
    \context {
      \Lyrics
      \remove Stanza_number_engraver
      \consists
        #(lambda (context)
           (let ((text #f)
                 (last-stanza #f))
             (make-engraver
              ((process-music engraver)
                 (let ((stanza (ly:context-property context 'stanza #f)))
                   (if (and stanza (not (equal? stanza last-stanza)))
                       (let ((column (ly:context-property context
'currentCommandColumn)))
                         (set! last-stanza stanza)
                         (if text
                             (ly:spanner-set-bound! text RIGHT column))
                         (set! text (ly:engraver-make-grob engraver
'StanzaNumberSpanner '()))
                         (ly:grob-set-property! text 'text stanza)
                         (ly:spanner-set-bound! text LEFT column)))))
              ((finalize engraver)
                 (if text
                     (let ((column (ly:context-property context
'currentCommandColumn)))
                       (ly:spanner-set-bound! text RIGHT column)))))))
      \override StanzaNumberSpanner.horizon-padding = 10000
    }
}

stanzaReminderOff =
  \temporary \override StanzaNumberSpanner.after-line-breaking =
     #(lambda (grob)
        ;; Can be replaced with (not (first-broken-spanner? grob)) in 2.23.
        (if (let ((siblings (ly:spanner-broken-into (ly:grob-original grob))))
              (and (pair? siblings)
                   (not (eq? grob (car siblings)))))
            (ly:grob-suicide! grob)))

stanzaReminderOn = \undo \stanzaReminderOff
% kết thúc mã nguồn

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \autoPageBreaksOff
  f8. g16 d8 c ~ |
  c a' a f16 (g) |
  c2 |
  c8. bf16 d8 c ~ |
  c a g16 (c) e,8 |
  f2 |
  g8. e16 d8 c ~ |
  c bf' bf a |
  g2 |
  g8. g16 g8 bf ~ |
  bf c e, g |
  f2 \bar "||" \break
  
  f8. c16 a' (bf)
  <<
    {
      \voiceOne
      a8
    }
    \new Voice = "splitpart" {
      \voiceTwo
      \tiny
      \once \override NoteColumn.force-hshift = #-2
      a16
      \once \override NoteColumn.force-hshift = #-2
      a
    }
  >>
  \oneVoice
  g4. e8 |
  f f4
  <<
    {
      \voiceOne
      d8
    }
    \new Voice = "splitpart" {
      \voiceTwo
      \tiny
      \once \override NoteColumn.force-hshift = #-1.5
      \parenthesize
      a'
    }
  >>
  \oneVoice
  c,2 |
  
  \pageBreak
  
  f8. c16 a' (bf)
  <<
    {
      \voiceOne
      a8
    }
    \new Voice = "splitpart" {
      \voiceTwo
      \tiny
      \once \override NoteColumn.force-hshift = #-2
      a16
      \once \override NoteColumn.force-hshift = #-2
      a
    }
  >>
  \oneVoice
  g4. g8 |
  bf bf4 c8 |
  f,2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  f8. g16 d8 c ~ |
  c f f [d] |
  e2 |
  a8. g16 bf8 a ~ |
  a f c [cs] |
  d2 |
  bf8. bf16 b!8 c ~ |
  c d g f |
  e2 |
  e8. e16 e8 d ~ |
  d d c bf |
  a2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \stanzaReminderOff
  \set stanza = "ĐK:"
  Ai sẽ loan truyền huân công của Chúa
  Ai sẽ xướng lên câu tán tụng Ngài.
  Phúc thay ai hằng giữ đức công minh,
  và hằng thực thi những điều ngay lành.
  \stanzaReminderOn
  <<
    {
      \set stanza = "1."
      Ôi lòng Chúa khoan nhân
      nào ta mau cảm tạ
      Ân tình Chúa bao la
      ngàn năm luôn vững bền.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Xin Ngài nhớ đến con
	    vì yêu thương dân Ngài
	    Xin ngự đến viếng thăm
	    và ban ơn cứu độ.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Xin được thấy phúc ân
	    danh cho ai
	    \markup { \underline \italic "Chúa" }
	    chọn
	    Tâm hồn sẽ sướng vui,
	    niềm vui dân thánh Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
      \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
      Trong ngàn nỗi truân chuyên
      cùng kêu van lên Ngài
      Theo lượng cả yêu thương
      Ngài ra tay cứu độ.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Ôi lạy Chúa chúng con
	    nguyện xin quy tụ về
	    Cho đoàn chúng con đây
	    ngợi ca danh thánh Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Như tiền bối trước kia
	    họ bao phen \markup { \italic \underline "lỗi" } phạm
	    Nhưng vì nhớ Thánh Danh,
	    Ngài ra tay cứu độ.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
      \set stanza = "7."
      Theo lời Chúa phán ra
      cạn khô ngay \markup { \italic \underline "biển" } Hồng
      Đưa họ tiến bước qua
      tựa đi trong đất liền.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "8."
      \override Lyrics.LyricText.font-shape = #'italic
	    Khi Ngài cứu thoát dân
	    khỏi bao tay quân thù
	    Tin lời Chúa đã ban
	    họ ca vang tán tụng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "9."
	    Nhưng họ chóng lãng quên
	    kỳ công tay \markup { \italic \underline "Chúa" } làm
	    Buông lòng với đam mê,
	    họ kêu than trách Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
      \set stanza = "10."
      \override Lyrics.LyricText.font-shape = #'italic
      Đem vàng đúc con bê
      tại chân Hô -- rép nọ
      Xin phục bái kính tôn
      bò bê thay Chúa họ.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "11."
	    Nên Ngài tính tru di
	    bọn dân ngoan \markup { \italic \underline "cố" } này
	    Nhưng nhờ có Mô -- sê,
	    Ngài nguôi cơn nghĩa nộ.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "12."
      \override Lyrics.LyricText.font-shape = #'italic
	    Khinh miền đất tốt tươi,
	    chẳng tin như \markup { \italic \underline "Chúa" } dậy
	    Trong trại chúng kêu ca,
	    chẳng nghe theo tiếng Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
      \set stanza = "13."
      Đi phục bái Ba -- an,
      tiệc thây ma \markup { \italic \underline "lãnh" } phần
      Trêu giận Chúa khôn ngơi
      làm tai ương dẫy đầy.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "14."
      \override Lyrics.LyricText.font-shape = #'italic
	    Bên dòng nước
	    \markup { \italic \underline "Mê - ri" } -- ba
	    họ trêu cơn giận Ngài
	    Do vậy khiến Mô -- sê
	    giận căm nên chuốc họa.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "15."
	    Chung đụng với chư dân
	    và đua theo \markup { \italic \underline "chúng" } hoài
	    Nên họ đã sa chân
	    mà suy tôn ngẫu thần.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
      \set stanza = "16."
      \override Lyrics.LyricText.font-shape = #'italic
      Đây họ giết con trai
      và luôn con \markup { \italic \underline "gái" } mình
      Dâng thần đất
      \markup { \italic \underline "Ca - na" } -- an
      làm hoen ô đất này.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "17."
	    Trên đầu lũ dân riêng
	    Ngài mưa cơn \markup { \italic \underline "nghĩa" } nộ
	    Trao mặc để chư dân
	    mạnh tay uy hiếp họ.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "18."
      \override Lyrics.LyricText.font-shape = #'italic
	    Bao lần Chúa cứu nguy,
	    họ khôi thôi \markup { \italic \underline "phản" } nghịch
	    Nhưng vì Thánh ước xưa,
	    Ngài yêu thương đoái lại.
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
  \key f \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
}

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
